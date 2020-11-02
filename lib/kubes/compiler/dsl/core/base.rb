module Kubes::Compiler::Dsl::Core
  class Base
    extend Fields
    include DslEvaluator
    include Helpers
    include Kubes::Compiler::Shared::CustomHelpers
    include Kubes::Compiler::Shared::CustomVariables
    include Kubes::Compiler::Shared::PluginHelpers

    def initialize(options={})
      @options = options
      @name = options[:name]
      @path = options[:path]
      load_plugin_helpers
      load_custom_variables
      load_custom_helpers
    end

    def run
      evaluate_file(@path) # main resource definition
      result if respond_to?(:result) # block form doesnt have result
    end
  end
end
