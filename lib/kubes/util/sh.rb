module Kubes::Util
  module Sh
    include Kubes::Logging

    def sh(command)
      command = "#{command}"
      logger.info "=> #{command}"
      success = system(command)
      unless success
        logger.error "ERROR: running #{command}".color(:red)
        exit $?.exitstatus
      end
      success
    end
  end
end
