class Kubes::CLI
  class Get < Base
    def run
      Compile.new(@options).run unless @options[:compile] == false
      Kubes::Kubectl.run(:get, @options)
    end
  end
end
