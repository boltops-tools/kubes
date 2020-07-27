module Kubes
  class Docker
    def initialize(options, name)
      @options = options
      @name = name
    end

    def run
      strategy = strategy_class.new(@options, @name) # @name: docker or push
      strategy.run
    end

    def strategy_class
      strategy = Kubes.config.build_strategy.to_s.camelize # IE: Docker or Gcloud
      klass_name = "Kubes::Docker::Strategy::#{@name.camelize}::#{strategy}"
      klass_name.constantize
    end
  end
end
