module Kubes::Dsl
  class Evalator
    include EvaluateFile
    include Syntax

    def initialize(options)
      @options = options
      @path = options[:path]
      @resource = {}
    end

    def run
      evaluate_file(path)
    end
  end
end
