module Kubes::Compiler::Dsl::Core
  class Base
    extend Fields
    include DslEvaluator
    include Helpers
    include Kubes::Compiler::Layering

    def initialize(options={})
      @options = options
      @name = options[:name]
      @path = options[:path]
    end

    def run
      evaluate_files(pre_layers)
      evaluate_file(@path) # main resource definition
      evaluate_files(post_layers)
      result if respond_to?(:result) # block form doesnt have result
    end

    def evaluate_files(paths)
      paths.each do |path|
        evaluate_file(path)
      end
    end
  end
end
