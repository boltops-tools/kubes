class Kubes::CLI
  class Delete < Base
    def run
      Compile.new(@options).run
      Kubes::Kubectl.run(:delete, @options)
    end
  end
end
