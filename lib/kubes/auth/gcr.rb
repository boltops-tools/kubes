class Kubes::Auth
  class Gcr < Base
    def run
      authorize! unless authorized?
    end

    def authorize!
      command = "gcloud auth configure-docker"
      logger.debug "Authorizing GCR with: #{command}"
      success = system(command)
      unless success
        logger.error "ERROR: running #{command}".color(:red)
        exit $?.exitstatus if exit_on_fail
      end
      success
    end

    def authorized?
      return false unless File.exist?(docker_config)
      data = JSON.load(IO.read(docker_config))
      !!data.dig('credHelpers', 'gcr.io')
    end
  end
end
