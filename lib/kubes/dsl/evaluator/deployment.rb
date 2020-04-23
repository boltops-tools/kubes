module Kubes::Dsl::Evaluator
  class Deployment < Resource
    setter_methods :spec, :strategy, :template, :containers, :container

    def spec
      @spec || default_spec
    end

    def default_spec
      {
        replicas: @replicas || 1,
        selector: {matchLabels: @labels},
        strategy: strategy,
        template: template,
      }
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
        metadata: {labels: @labels},
        containers: containers,
      }
    end

    def containers
      @containers || [container]
    end

    def container
      @container || default_container
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
