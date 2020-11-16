require "render_me_pretty"

class Kubes::Compiler::Strategy
  class Erb < Base
    extend Kubes::Compiler::Dsl::Core::Fields
    include Kubes::Compiler::Dsl::Core::Helpers
    include Kubes::Compiler::Layering
    include Kubes::Compiler::Shared::RuntimeHelpers

    def initialize(options={})
      super
      # For ERB scope is in this same Strategy::Erb class
      # For DSL scope is within the each for the Resource classes. IE: kubes/compile/dsl/core/base.rb
      load_runtime_helpers
    end

    def render_result(path)
      return unless File.exist?(path)

      yaml = RenderMePretty.result(path, context: self)
      result = yaml_load(path, yaml)
      # in case of blank yaml doc a Boolean false is returned. else Hash or Array is returned
      %w[Array Hash].include?(result.class.to_s) ? result : {}
    end

    def yaml_load(path, yaml)
      YAML.load(yaml)
    rescue Psych::SyntaxError
      YamlError.new(path, yaml).show
      exit 1
    end
  end
end
