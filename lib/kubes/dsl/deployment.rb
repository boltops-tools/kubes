module Kubes::Dsl
  class Deployment < Resource
    setter_methods :container, :containers, :match_labels, :selector, :sidecar, :spec, :strategy, :template

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
      @selector || match_labels
    end

    def match_labels
      default = {matchLabels: labels} if labels
      @match_labels || default
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
      default = {labels: labels} if labels
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
      }
      if @container_port
        props[:container_port] = @container_port
      end
      props
    end
  end
end
