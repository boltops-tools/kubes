class Kubes::CLI
  class Delete < Base
    def run
      Kubectl.new(@options).delete
    end
  end
end
