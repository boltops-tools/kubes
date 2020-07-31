class Kubes::CLI
  class Describe < Base
    def run
      compile
      Kubes::Kubectl.run(:describe, @options)
    end
  end
end
