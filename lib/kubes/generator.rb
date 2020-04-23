module Kubes
  class Generator
    def initialize(options)
      @options = options
      @path = @options[:path]
    end

    def run
    end


    # def run
    #   evaluator = Dsl::Evaluator.new(path: @path)
    #   evaluator.run
    #   deployment = Builder::Deployment.new(evaluator.vars)
    #   resource = deployment.build
    #   puts YAML.dump(resource)
    # end
  end
end
