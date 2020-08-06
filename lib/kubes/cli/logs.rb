class Kubes::CLI
  class Logs < Base
    include Kubes::Util::Sh

    def run
      compile
      metadata = Kubes::Kubectl::Fetch::Deployment.new(@options).metadata
      name = metadata['name']
      ns = metadata['namespace']

      follow = " -f" if @options[:follow]
      sh("kubectl logs deployment/#{name}#{follow} -n #{ns}")
    end
  end
end
