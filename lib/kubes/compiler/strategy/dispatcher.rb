class Kubes::Compiler::Strategy
  class Dispatcher < Base
    def dispatch
      show_layers if Kubes.config.layering.show
      result = render(@path) # main
      results = [result].flatten # ensure array
      data = results.map! do |main|
        hash = Kubes.deep_merge!(pre_layer, main)
        Kubes.deep_merge!(hash, post_layer)
      end
      logger.info "Compiled .kubes/output/#{@save_file}" if Kubes.config.layering.show
      Result.new(@save_file, data)
    end

    def show_layers
      logger.info "Compiling #{pretty_path(@path)}"
      logger.info "    Resource layers:"
      all_layers = pre_layers + [@path] + post_layers
      all_layers.each do |layer|
        logger.info "    #{pretty_path(layer)}"
      end
    end

    # Render via to Erb or one of the DSL syntax classes or Core/Blocks class
    def render(path)
      if path.include?('.rb')
        klass = dsl_class(path) # IE: Kubes::Compiler::Dsl::Syntax::Deployment or Kubes::Compiler::Dsl::Core::Blocks
        klass.new(@options.merge(path: path, data: @data)).run
      else
        logger.info "Rendering #{pretty_path(path)}" if ENV['KUBES_LAYERING_SHOW_RENDERING']
        Erb.new(@options.merge(data: @data)).render_result(path)
      end
    end

    # Must be defined here in case coming from Kubes::Compiler::Strategy::Erb#render
    def dsl_class(path)
      if block_form?(path)
        Kubes::Compiler::Dsl::Core::Blocks
      else
        syntax_class
      end
    end

    def syntax_class
      klass_name = normalize_kind(@save_file) # IE: @save_file: web/service.yaml
      "Kubes::Compiler::Dsl::Syntax::#{klass_name}".constantize
    rescue NameError
      logger.debug "Using default resource for: #{klass_name}"
      Kubes::Compiler::Dsl::Syntax::Resource # default
    end

    def block_form?(path)
      type = extract_type(path)
      type.pluralize == type
    end

    def pre_layer
      merge_layers(pre_layers)
    end

    def post_layer
      merge_layers(post_layers)
    end

    def merge_layers(layers)
      layers.inject({}) do |hash, layer|
        data = render(layer)
        hash.deep_merge!(data)
      end
    end
  end
end
