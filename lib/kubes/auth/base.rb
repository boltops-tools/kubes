require "json"

class Kubes::Auth
  class Base
    include Kubes::Logging

    def initialize(image)
      @image = image
      @repo_domain = "#{image.split('/').first}"
    end

    def ensure_dotdocker_exists
      dirname = File.dirname(docker_config)
      FileUtils.mkdir_p(dirname) unless File.exist?(dirname)
    end

    def docker_config
      "#{ENV['HOME']}/.docker/config.json"
    end
  end
end
