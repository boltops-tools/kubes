module Kubes::Compiler::Shared::Helpers
  module DockerHelper
    def docker_image
      return @options[:image] if @options[:image] # override
      return Kubes.config.image if Kubes.config.image
      built_image_helper
    end

    def built_image
      Deprecated.new.built_image
      built_image_helper
    end

    def built_image_helper
      path = Kubes.config.state.path
      unless File.exist?(path)
        raise Kubes::MissingDockerImage.new("Missing file with docker image built by kubes: #{path}. Try first running: kubes docker build")
      end
      data = JSON.load(IO.read(path))
      data['image']
    end
  end
end
