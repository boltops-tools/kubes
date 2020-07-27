module Kubes::Docker::Strategy::Build
  class Base
    extend Memoist
    include Kubes::Docker::Strategy::Utils

    def initialize(options, name)
      @options, @name = options, name
    end

    def run
      reserve_image_name
      check_dockerfile!
      perform
      store_image_name
    end

    def check_dockerfile!
      # Dockerfile is also used in args/default.rb, will have to combine if Dockerfile is made configurable
      return if File.exist?("Dockerfile")
      logger.error "ERROR: The Dockerfile does not exist. Cannot build the docker image without a Dockerfile".color(:red)
      exit 1
    end
  end
end
