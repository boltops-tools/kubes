class Kubes::CLI
  class Base
    include Kubes::Logging

    def initialize(options={})
      @options = options
    end

    def compile
      Compile.new(@options).run unless @options[:compile] == false
    end

    def pod_name
      return unless @options[:pod]

      pods = Kubes::Kubectl::Fetch::Pods.new(@options)
      items = pods.fetch(:pod)
      metas = items.map { |i| i['metadata'] }
      metas.select! { |i| i['name'].include?(@options[:pod]) }
      meta = metas.sort { i['creationTimestamp'] }.last
      meta['name'] if meta
    end
  end
end
