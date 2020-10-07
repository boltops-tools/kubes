class Kubes::CLI
  class Get < Base
    def run
      compile
      Kubes::Kubectl.run(:get, @options.merge(exit_on_fail: false))
      return unless @options[:show_pods]
      pods = Kubes::Kubectl::Fetch::Pods.new(@options)
      pods.show
    end
  end
end
