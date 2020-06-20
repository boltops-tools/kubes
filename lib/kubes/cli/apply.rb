class Kubes::CLI
  class Apply < Base
    def run
      Compile.new(@options).run unless @options[:compile] == false
      logger.info "Deploying kubes files"
      Kubes::Kubectl::Batch.new(:apply, @options).run
    end
  end
end
