class Kubes::CLI
  class Apply < Base
    def run
      Compile.new(@options).run unless @options[:compile] == false
      Kubes::Kubectl.run(:apply, @options)
    end
  end
end
