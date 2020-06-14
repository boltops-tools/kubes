class Kubes::CLI
  class Delete < Base
    def run
      Compile.new(@options).run
      Kubectl.run(:delete, @options)
    end
  end
end
