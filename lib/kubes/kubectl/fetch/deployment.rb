module Kubes::Kubectl::Fetch
  class Deployment < Base
    extend Memoist

    def metadata
      deployment['metadata'] if found
    end

    def spec
      deployment['spec'] if found
    end

    def deployment
      items = fetch(:deployment)
      # Not checking if deployment exists because kubes will error on `kubes get` from missing deployments already
      deployments = items.select { |i| i['kind'] == "Deployment" }

      if !@options[:deployment] && !@options[:pod] && deployments.size > 1
        names = deployments.map { |d| d['metadata']['name'] }
        logger.info <<~EOL
          INFO: More than one deployment found.
          Deployment names: #{names.join(', ')}
          Using #{names.first}
          Note: You can specify the deployment to use with --deployment or -d
        EOL
      end

      find_deployment(deployments)
    end
    memoize :deployment

    def found
      !!deployment
    end

    def find_deployment(deployments)
      if @options[:deployment]
        deployments.find { |d| d['metadata']['name'] == @options[:deployment] }
      else
        deployments.first
      end
    end
  end
end
