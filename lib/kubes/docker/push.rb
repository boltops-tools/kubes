module Kubes::Docker
  class Push < Base
    extend Memoist
    include Kubes::Logging
    include Kubes::Util::Time

    delegate :image_name, to: :builder
    def initialize(options)
      @options = options
    end

    def run
      update_auth_token
      start_time = Time.now
      message = "Pushed #{image_name} docker image."
      if @options[:noop]
        message = "NOOP #{message}"
      else
        command = "docker push #{image_name}"
        logger.info "=> #{command}".color(:green)
        success = sh(command)
        unless success
          logger.error "ERROR: The docker image fail to push.".color(:red)
          exit 1
        end
      end
      took = Time.now - start_time
      message << "\nDocker push took #{pretty_time(took)}.".color(:green)
      logger.info message
    end

    def builder
      Build.new(@options)
    end
    memoize :builder

    def update_auth_token
      auth = Kubes::Auth.new(image_name)
      auth.run
    end
  end
end
