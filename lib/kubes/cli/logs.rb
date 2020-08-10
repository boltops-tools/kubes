class Kubes::CLI
  class Logs < Base
    include Kubes::Util::Sh

    def run
      compile
      deployment = Kubes::Kubectl::Fetch::Deployment.new(@options)
      metadata = deployment.metadata
      name = metadata['name']
      ns = metadata['namespace']

      follow = " -f" if @options[:follow]
      c = container(deployment)
      sh("kubectl logs deployment/#{name}#{follow} -n #{ns} -c #{c}")
    end

  private
    def container(deployment)
      container = @options[:container]
      return container if container

      spec = deployment.spec
      containers = spec['template']['spec']['containers']
      names = containers.map { |c| c['name'] }
      if containers.size > 1
        logger.info <<~EOL
          INFO: More than one container found.
          Container names: #{names.join(', ')}
          Using #{names.first}
          Note: You can specify the container to use with --container or -c
        EOL

        names.first
      end
    end
  end
end
