class Kubes::CLI
  class Apply < Base
    def run
      Kubectl.new(@options).apply
    end
  end
end
