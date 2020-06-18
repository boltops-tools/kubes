module Kubes::Compiler::Dsl::Syntax
  class Deployment < Resource
    attribute_methods :command,
                      :container,
                      :containers,
                      :matchLabels,
                      :replicas,
                      :selector,
                      :sidecar,
                      :strategy,
                      :template,
                      :templateMetadata,
                      :templateSpec

    def default_apiVersion
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

    def default_replicas
      1
    end

    def default_selector
      {matchLabels: matchLabels}
    end

    def default_matchLabels
      labels
    end

    def default_strategy
      {
        rollingUpdate: {
          maxSurge: @maxSurge || 25,
          maxUnavailable: @maxUnavailable || 25
        },
        type: "RollingUpdate",
      }
    end

    def default_template
      {
        metadata: templateMetadata,
        spec: templateSpec,
      }
    end

    def default_templateSpec
      {
        containers: containers,
      }
    end

    def default_templateMetadata
      {labels: labels}
    end

    def default_containers
      [container, sidecar].compact
    end

    def default_container
      {
        command: command,
        image: @image,
        name: @name,
      }
    end

    # Override command instead of default_command since we want to change a String to an Array
    def command
      @command.is_a?(String) ? @command.split(' ') : @command # else assume Array
    end
  end
end
