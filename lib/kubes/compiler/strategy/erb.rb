require "render_me_pretty"

class Kubes::Compiler::Strategy
  class Erb < Base
    extend Kubes::Compiler::Dsl::Core::Fields
    include Kubes::Compiler::Dsl::Core::Helpers
    include Kubes::Compiler::Shared::CustomHelpers
    include Kubes::Compiler::Shared::Helpers
    include Kubes::Compiler::Layering

    def run
      load_custom_helpers
      @data = {}

      render_files(pre_layers)
      render(@path) # main resource definition
      render_files(post_layers)

      Result.new(@save_file, @data)
    end

    def render_files(paths)
      paths.each do |path|
        render(path)
      end
    end

    # render and merge
    def render(path)
      result = render_result(path)
      @data.deeper_merge!(result)
    end

    def render_result(path)
      if File.exist?(path)
        yaml = RenderMePretty.result(path, context: self)
        result = yaml_load(path, yaml)
        result.is_a?(Hash) ? result : {} # in case of blank yaml doc a Boolean false is returned
      else
        {}
      end
    end

    def yaml_load(path, yaml)
      YAML.load(yaml)
    rescue Psych::SyntaxError
      YamlError.new(path, yaml).show
      exit 1
    end
  end
end
