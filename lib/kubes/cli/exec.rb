class Kubes::CLI
  class Exec < Base
    extend Memoist
    include Kubes::Logging
    include Kubes::Util::Sh

    def run
      compile
      pod = find_pod

      unless pod
        logger.info <<~EOL
          Unable to find a pod to exec into. This means there was no deployment found.
          You can also try using the -p option and specifying enough of the pod name. Example:

              kubes exec -p web

        EOL
        exit 1
      end

      container = " -c #{@options[:container]}" unless @options[:container].nil?
      cmd = @options[:cmd].empty? ? "bash" : @options[:cmd].join(' ')
      sh("kubectl exec #{ns} -ti #{pod}#{container} -- #{cmd}")
    end

    def find_pod
      pod_name || deployment_pod
    end

    def ns
      "-n #{metadata['namespace']}" if metadata
    end

    def metadata
      deployment = Kubes::Kubectl::Fetch::Deployment.new(@options)
      deployment.metadata if deployment.found
    end
    memoize :metadata

    def deployment_pod
      return unless metadata
      labels = metadata['labels'].map { |k,v| "#{k}=#{v}" }.join(',')
      ns = metadata['namespace']

      resp = sh_capture("kubectl get pod -l #{labels} -n #{ns} -o json")
      data = JSON.load(resp)
      pod = latest_pod(data['items'])

      unless pod
        logger.error "ERROR: Unable to find a running pod".color(:red)
        exit 1
      end

      pod['metadata']['name']
    end

    # get latest running pod
    def latest_pod(items)
      running = items.select { |i| i['status']['phase'] == 'Running' }
      sorted = running.sort_by { |i| i['metadata']['creationTimestamp'] || 0 }
      sorted.last
    end
  end
end
