class Kubes::CLI
  class Describe < Base
    def run
      Compile.new(@options).run unless @options[:compile] == false
      Kubes::Kubectl.run(:describe, @options)
    end
  end
end
