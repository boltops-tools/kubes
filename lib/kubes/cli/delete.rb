class Kubes::CLI
  class Delete < Base
    def run
      Compile.new(@options).run
      Kubectl.new(@options).delete
    end
  end
end
