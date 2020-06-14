class Kubes::Compiler::Strategy
  class Dsl < Base
    def run
      klass = syntax_class
      syntax = klass.new(@options) # Deployment, Service, etc
      yaml = syntax.run
      Result.new(@save_file, yaml)
    end

    def syntax_class
      # Remove .kubes/resources
      klass_name = File.basename(@filename).sub('.rb','').camelize # Deployment, Service, etc
      "Kubes::Compiler::Dsl::Syntax::#{klass_name}".constantize
    end
  end
end
