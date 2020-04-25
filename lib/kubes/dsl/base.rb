module Kubes::Dsl
  class Base
    include EvaluateFile

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
