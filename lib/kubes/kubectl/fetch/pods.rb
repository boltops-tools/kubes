module Kubes::Kubectl::Fetch
  class Pods < Base
    def show
      items = fetch_items
      # Not checking if deployment exists because kubes will error on `kubes get` from missing deployments already
      deployments = items.select { |i| i['kind'] == "Deployment" }

      deployments.each do |deployment|
        logger.info "Pods for deployment #{deployment['metadata']['name']}:".color(:green)
        show_for(deployment)
      end
    end

    def show_for(deployment)
      metadata = deployment['metadata']
      labels = metadata['labels'].map { |k,v| "#{k}=#{v}" }.join(',')
      ns = metadata['namespace']
      sh("kubectl get pod -l #{labels} -n #{ns}")
    end
  end
end
