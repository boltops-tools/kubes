class Kubes::CLI
  class Exec < Base
    include Kubes::Util::Sh

    def run
      compile
      metadata = Kubes::Kubectl::Fetch::Deployment.new(@options).metadata

      labels = metadata['labels'].map { |k,v| "#{k}=#{v}" }.join(',')
      ns = metadata['namespace']

      resp = capture("kubectl get pod -l #{labels} -n #{ns} -o json")
      data = JSON.load(resp)
      pod = latest_pod(data['items'])

      unless pod
        logger.error "ERROR: Unable to find a running pod".color(:red)
        exit 1
      end

      name = pod['metadata']['name']
      cmd = @options[:cmd].empty? ? "bash" : @options[:cmd].join(' ')
      sh("kubectl exec -n #{ns} -ti #{name} -- #{cmd}")
    end

    # get latest running pod
    def latest_pod(items)
      running = items.select { |i| i['status']['phase'] == 'Running' }
      sorted = running.sort_by { |i| i['metadata']['creationTimestamp'] || 0 }
      sorted.last
    end
  end
end
