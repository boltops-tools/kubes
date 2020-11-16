module Kubes::Compiler::Dsl::Core
  class Base
    extend Fields
    include DslEvaluator
    include Helpers
    include Kubes::Compiler::Shared::RuntimeHelpers

    def initialize(options={})
      @options = options
      @name = options[:name]
      @path = options[:path]
      load_runtime_helpers
    end

    def run
      evaluate_file(@path) # main resource definition
      result
    end
  end
end
