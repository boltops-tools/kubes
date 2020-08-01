module Kubes::Util
  module Sh
    include Kubes::Logging

    def sh(command, options={})
      mute = options[:mute]
      show_command = options[:show_command].nil? ? !mute : options[:show_command]
      exit_on_fail = options[:exit_on_fail].nil? ? true : options[:exit_on_fail]

      # Logger::DEBUG = 0
      # Logger::INFO  = 1
      if logger.level <= Logger::DEBUG
        mute = false
        show_command = true
      end

      env = options[:env] || {}
      env.stringify_keys!

      command = "#{command}"
      if mute && !command.include?("2>&1")
        command = "#{command} > /dev/null 2>&1"
      end
      logger.info "=> #{command}" if show_command
      success = system(env, command)
      unless success
        logger.error "ERROR: running #{command}".color(:red)
        exit $?.exitstatus if exit_on_fail
      end
      success
    end

    def capture(command, options={})
      exit_on_fail = options[:exit_on_fail].nil? ? true : options[:exit_on_fail]
      logger.info "=> #{command}" if options[:show_command]
      out = `#{command}`.strip
      unless $?.success?
        logger.error "ERROR: running #{command}".color(:red)
        exit $?.exitstatus if exit_on_fail
      end
      out
    end
  end
end
