class Kubes::CLI
  class Logs < Base
    include Kubes::Logging
    include Kubes::Util::Sh

    def run
      compile
      sh("kubectl logs #{args}")
    end

  private
    def args
      args = pod_name || deployment_args

      unless args
        logger.info <<~EOL
          Unable to find a pod to show logs for. This means there was no deployment found.
          You can also try using the -p option and specifying enough of the pod name. Example:

              kubes logs -p web

        EOL
        exit 1
      end

      follow = " -f" if @options[:follow]
      "#{args}#{follow}"
    end

    def deployment_args
      deployment = Kubes::Kubectl::Fetch::Deployment.new(@options)
      metadata = deployment.metadata
      return unless metadata

      name = metadata['name']
      ns = metadata['namespace']

      container = container(deployment)
      c = " -c #{container}" if container
      "deployment/#{name} -n #{ns}#{c}"
    end

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
