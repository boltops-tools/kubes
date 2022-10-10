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
      strategy = Kubes.config.builder.to_s.camelize # IE: Docker or Gcloud
      klass_name = "Kubes::Docker::Strategy::#{@name.camelize}::#{strategy}"
      klass_name.constantize
    end

    # For `kubes docker image` and read_image_name method
    include Kubes::Docker::Strategy::ImageName
  end
end
