class Kubes::CLI
  class Get < Base
    def run
      compile
      Kubes::Kubectl.run(:get, @options)
      pods = Kubes::Kubectl::Fetch::Pods.new(@options)
      pods.show if @options[:show_pods]
    end
  end
end
