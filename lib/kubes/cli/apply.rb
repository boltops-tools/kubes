class Kubes::CLI
  class Apply < Base
    def run
      compile
      logger.info "Deploying kubes resources"
      Kubes::Kubectl::Dispatcher.new(:apply, @options).run
    end
  end
end
