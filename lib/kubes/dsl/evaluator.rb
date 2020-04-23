module Kubes::Dsl
  class Evaluator
    include EvaluateFile
    include Syntax

    attr_reader :vars
    def initialize(options)
      @options = options
      @path = options[:path]
      @vars = {}
    end

    def run
      evaluate_file(@path)
      copy_instance_variables
    end

    # Copy instance variables defined in users' DSL, IE: deployment.rb, to @vars
    def copy_instance_variables
      instance_variables.each do |var|
        val = instance_variable_get(var)
        key = var.to_s.sub('@','').to_sym # remove beginning @
        @vars[key] = val
      end
    end
  end
end
