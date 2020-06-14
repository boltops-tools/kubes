class Kubes::CLI
  class Apply < Base
    def run
      Kubectl.run(:apply, @options)
    end
  end
end
