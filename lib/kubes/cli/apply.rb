class Kubes::CLI
  class Apply < Base
    def run
      Compile.new(@options).run unless @options[:compile] == false
      logger.info "Deploying kubes files"
      Kubes::Applier.new(@options).run
    end
  end
end
