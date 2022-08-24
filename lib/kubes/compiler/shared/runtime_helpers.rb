module Kubes::Compiler::Shared
  module RuntimeHelpers
    include Kubes::Compiler::Shared::Helpers
    include Kubes::Util::Pretty

    def load_runtime_helpers
      load_plugin_helpers
      load_custom_helpers
      load_custom_variables # also load custom variables
    end

    @@custom_helpers_loaded = false
    def load_custom_helpers
      return if @@custom_helpers_loaded
      paths = Dir.glob("#{Kubes.root}/.kubes/helpers/**/*.rb")
      paths.sort_by! { |p| p.size } # so namespaces are loaded first

      paths.each do |path|
        filename = path.sub(%r{.*.kubes/helpers/},'').sub('.rb','')
        module_name = filename.camelize
        base_class_for_helper.send :include, module_name.constantize
      end
      @@custom_helpers_loaded = true
    end

    # Load plugin helper methods from project
    @@plugin_helpers_loaded = false
    def load_plugin_helpers
      return if @@plugin_helpers_loaded
      Kubes::Plugin.plugins.each do |klass|
        helpers_class = "#{klass}::Helpers".constantize # IE: KubesAws::Helpers
        base_class_for_helper.send :include, helpers_class
      end
      @@plugin_helpers_loaded = true
    end

    def base_class_for_helper
      if self.is_a?(Kubes::Compiler::Strategy::Erb)
        Kubes::Compiler::Strategy::Erb
      else
        Kubes::Compiler::Dsl::Core::Base
      end
    end

    include DslEvaluator
    # Load custom variables from project
    @@custom_variables_loaded = false
    def load_custom_variables
      return if Kubes.kustomize?

      ext = File.extname(@path)
      role = @path.sub(%r{.*\.kubes/resources/},'').sub(ext,'').split('/').first # IE: web
      kind = File.basename(@path).sub(ext,'') # IE: deployment
      all = "all"
      if @block_form
        kind = kind.pluralize
        all = all.pluralize
      end

      layers = [
        "base.rb",
        "#{Kubes.env}.rb",
        "#{Kubes.env}-#{Kubes.extra}.rb",
        "base/all.rb",
        "base/all/#{Kubes.env}.rb",
        "base/all/#{Kubes.env}-#{Kubes.extra}.rb",
        "base/#{kind}.rb",
        "base/#{kind}/base.rb",
        "base/#{kind}/#{Kubes.env}.rb",
        "base/#{kind}/#{Kubes.env}-#{Kubes.extra}.rb",
        "#{role}/#{kind}.rb",
        "#{role}/#{kind}/base.rb",
        "#{role}/#{kind}/#{Kubes.env}.rb",
        "#{role}/#{kind}/#{Kubes.env}-#{Kubes.extra}.rb",
      ]
      # filter out the -.rb layers when Kubes.extra is not set
      # IE: .kubes/variables/dev-.rb
      layers.reject! { |layer| layer.ends_with?('-.rb') }

      if Kubes.app
        app_layers = ["#{Kubes.app}.rb"]
        app_layers += layers.map do |path|
          "#{Kubes.app}/#{path}"
        end
        layers += app_layers
      end

      layer_paths = layers.map { |layer| "#{Kubes.root}/.kubes/variables/#{layer}" }
      layer_paths = layer_paths.select { |path| File.exist?(path) } unless ENV['KUBES_LAYERING_SHOW_ALL']
      layer_paths.each do |path|
        show_variable_layer_path(path)
        evaluate_file(path)
      end
    end

    @@header_shown = {} # key is main @path
    @@shown = {}
    def show_variable_layer_path(path)
      main_path = @path # main path is main resource file

      show_header = !@@header_shown.dig(main_path)
      if show_header && Kubes.config.layering.show
        logger.info "    Variables layers:"
        @@header_shown[main_path] = true
      end
      # Examples:
      #   .kubes/resources/web/deployment.yaml
      #   .kubes/resources/shared/namespace.yaml
      show_once = !@@shown.dig(main_path, path)
      show_layer = Kubes.config.layering.show && show_once
      if show_layer
        logger.info "    #{pretty_path(path)}"
        @@shown[main_path] ||= {}
        @@shown[main_path][path] = true
      end
    end
  end
end
