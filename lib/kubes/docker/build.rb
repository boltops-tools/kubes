module Kubes::Docker
  class Build < Base
    def run
      reserve_image_name
      build
      store_image_name
    end

    def build
      # Dockerfile is also used in args/default.rb, will have to combine if Dockerfile is made configurable
      unless File.exist?("Dockerfile")
        logger.error "ERROR: The Dockerfile does not exist. Cannot build the docker image without a Dockerfile".color(:red)
        exit 1
      end
      params = args.flatten.join(' ')
      command = "docker build #{params}"
      run_hooks "build" do
        sh(command)
      end
    end
  end
end
