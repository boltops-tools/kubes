class Kubes::Compiler::Strategy
  class Base
    include Kubes::Compiler::Layering
    include Kubes::Compiler::Util::Normalize
    include Kubes::Compiler::Util::SaveFile
    include Kubes::Logging

    def initialize(options={})
      @options = options
      @path = options[:path]
      @save_file = save_file(@path)
      @data = @options[:data] || {}
    end

    def run
      render_files(pre_layers)
      render(@path) # main resource definition
      render_files(post_layers)

      Result.new(@save_file, @data)
    end

    def render_files(paths)
      paths.each do |path|
        next unless File.exist?(path) # layers may not exist
        render(path)
      end
    end

    # render and merge
    def render(path)
      result = render_strategy(path)
      if result.is_a?(Kubes::Compiler::Dsl::Core::Blocks)
        result = result.results
      end
      @data.deeper_merge!(result)
    end

    # Delegate to Dsl or Erb strategy again and pass @data down to allow rendering of a mix of yaml and rb files.
    def render_strategy(path)
      if path.include?('.rb')
        dsl_class.new(@options.merge(path: path, data: @data)).run
      else
        Erb.new(@options.merge(data: @data)).render_result(path)
      end
    end

    # Must be defined here in case coming from Kubes::Compiler::Strategy::Erb#render_strategy
    def dsl_class
      if block_form?
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

    def block_form?
      type = extract_type(@save_file)
      type.pluralize == type
    end
  end
end
