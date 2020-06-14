class Kubes::CLI
  class Clean < Base
    def run
      path = ".kubes/output"
      FileUtils.rm_rf("#{Kubes.root}/#{path}")
      logger.info "Removed #{path}" unless @options[:mute]
    end
  end
end
