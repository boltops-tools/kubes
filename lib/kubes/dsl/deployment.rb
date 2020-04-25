module Kubes::Dsl
  class Deployment < Resource
    attr_reader :sidecar
    setter_methods :container, :containers, :matchLabels, :selector, :sidecar, :spec, :strategy, :template, :templateMetadata

    def default_api_version
      "apps/v1"
    end

    def default_spec
      {
        replicas: replicas,
        selector: selector,
        strategy: strategy,
        template: template,
      }
    end

    def replicas
      @replicas || 1
    end

    def selector
      @selector || {matchLabels: matchLabels}
    end

    def matchLabels
      @matchLabels || labels
    end

    def strategy
      @strategy || {
        rollingUpdate: {
          maxSurge: @maxSurge || 25,
          maxUnavailable: @maxUnavailable || 25
        },
        type: "RollingUpdate",
      }
    end

    def template
      @template || {
        metadata: templateMetdata,
        containers: containers,
      }
    end

    def templateMetdata
      @templateMetdata || {labels: labels}
    end

    def containers
      @containers || [container, sidecar].compact
    end

    def container
      @container || default_container
    end

    def default_container
      {
        name: @name,
        image: @image,
        containerPort: @containerPort,
      }
    end
  end
end
