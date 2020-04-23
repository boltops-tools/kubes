module Kubes::Builder
  class Deployment < Resource
    def spec
      { replicas: @replicas || 1,
        selector: {matchLabels: @labels},
        strategy: strategy,
        template: template,
      }
    end

    def strategy
      {
         rollingUpdate: {
           maxSurge: @max_surge || 25,
           maxUnavailable: @max_unavailable || 25
        },
        type: "RollingUpdate",
      }
    end

    def template
      {
        metadata: {labels: @labels},
        containers: containers,
      }
    end

    def containers
      @containers || []
    end
  end
end
