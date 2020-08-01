class Kubes::CLI
  class Logs < Base
    include Kubes::Util::Sh

    def run
      compile
      metadata = Kubes::Kubectl::Fetch::Deployment.new(@options).metadata
      name = metadata['name']
      follow = " -f" if @options[:follow]
      sh("kubectl logs deployment/#{name}#{follow}")
    end
  end
end
