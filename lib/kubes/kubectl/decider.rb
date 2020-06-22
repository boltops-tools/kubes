class Kubes::Kubectl
  class Decider
    def initialize(name, options={})
      @name, @options = name.to_s, options
    end

    def run
      if Kubes.kustomize?
        Kubes::Kubectl.run(@name, @options)
      else
        Kubes::Kubectl::Batch.new(@name, @options).run
      end
    end
  end
end
