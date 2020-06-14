module Kubes::Util
  module Sh
    include Kubes::Logging

    def sh(command, options={})
      exit_on_fail = options[:exit_on_fail].nil? ? true : options[:exit_on_fail]
      env = options[:env] || {}
      env.stringify_keys!

      command = "#{command}"
      logger.info "=> #{command}"
      success = system(env, command)
      unless success
        logger.error "ERROR: running #{command}".color(:red)
        exit $?.exitstatus if exit_on_fail
      end
      success
    end
  end
end
