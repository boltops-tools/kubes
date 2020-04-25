module Kubes::Dsl
  class Deployment < Resource
    setter_methods :container, :containers, :matchLabels, :selector, :sidecar, :spec, :strategy, :template

    def default_api_version
      "apps/v1"
    end

    def default_spec
      {
        replicas: @replicas || 1,
        selector: selector,
        strategy: strategy,
        template: template,
      }
    end

    def selector
      @selector || matchLabels
    end

    def matchLabels
      @matchLabels || {matchLabels: labels}
    end

    def strategy
      @strategy || {
        rollingUpdate: {
          maxSurge: @max_surge || 25,
          maxUnavailable: @max_unavailable || 25
        },
        type: "RollingUpdate",
      }
    end

    def template
      @template || {
        metadata: template_metdata,
        containers: containers,
      }
    end

    def template_metdata
      default = {labels: labels}
      @template_metdata || default
    end

    def containers
      @containers || [container, sidecar].compact
    end

    def container
      @container || default_container
    end

    def sidecar
      @sidecar
    end

    def default_container
      props = {
        name: @name,
        image: @image,
        containerPort: @containerPort,
      }
      props
    end
  end
end
