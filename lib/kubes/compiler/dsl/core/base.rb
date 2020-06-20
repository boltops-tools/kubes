module Kubes::Compiler::Dsl::Core
  class Base
    extend FieldMethods
    include DslEvaluator
    include Helpers
    include Kubes::Compiler::Layering

    def initialize(options)
      @options = options
      @path = options[:path]
    end

    def run
      evaluate_file(@path)
      layers.each do |path|
        evaluate_file(path)
      end
      resource
    end
  end
end
