module Kubes::Compiler::Dsl::Syntax
  class Deployment < Resource
    attr_reader :sidecar
    setter_methods :container, :containers, :matchLabels, :selector, :sidecar, :spec, :strategy, :template, :templateMetadata

    def default_api_version
      "apps/v1"
    end

    def top_spec
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
        spec: template_spec,
      }
    end

    def template_spec
      {
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
        command: command,
        image: @image,
        name: @name,
      }
    end

    def command
      return unless @command
      @command.is_a?(String) ? @command.split(' ') : @command # else assume Array
    end
  end
end
