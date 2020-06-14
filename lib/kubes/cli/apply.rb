class Kubes::CLI
  class Apply < Base
    def run
      Kubes::Kubectl.run(:apply, @options)
    end
  end
end
