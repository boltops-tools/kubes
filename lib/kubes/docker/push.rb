module Kubes::Docker
  class Push < Base
    include Kubes::Logging
    include Kubes::Util::Time

    def run
      update_auth_token
      start_time = Time.now
      message = "Pushed #{image_name} docker image."
      if @options[:noop]
        message = "NOOP #{message}"
      else
        push
      end
      took = Time.now - start_time
      message << "\nDocker push took #{pretty_time(took)}.".color(:green)
      logger.info message
    end

    def push
      params = args.flatten.join(' ')
      command = "docker push #{params}"
      run_hooks "push" do
        sh(command)
      end
    end

    def update_auth_token
      auth = Kubes::Auth.new(image_name)
      auth.run
    end
  end
end
