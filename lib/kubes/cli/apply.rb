class Kubes::CLI
  class Apply < Base
    def run
      compile
      logger.info "Deploying kubes resources"
      Kubes::Kubectl::Dispatcher.new(:apply, @options).run
      Prune.new(@options.merge(yes: true, quiet: true)).run if Kubes.config.auto_prune # prune old secrets and config maps
    end
  end
end
