module Kubes::Dsl::Evaluator
  class Base
    include EvaluateFile

    attr_reader :vars
    def initialize(options)
      @options = options
      @path = options[:path]
    end

    def run
      evaluate_file(@path)
      build
    end
  end
end
