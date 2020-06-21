module Kubes::Compiler::Dsl::Syntax
  class Deployment < Resource
    fields :container,          # <Object>
           :containers,         # <[]Object>
           "matchLabels:hash",  # <map[string]string>
           :sidecar,            # <Object>
           :templateMetadata,   # <Object>
           :templateSpec        # <Object>

    # kubectl explain deployment.spec
    fields :minReadySeconds,         # <integer>
           :paused,                  # <boolean>
           :progressDeadlineSeconds, # <integer>
           :replicas,                # <integer>
           :revisionHistoryLimit,    # <integer>
           :selector,                # <Object> -required-
           :strategy,                # <Object>
           :template                 # <Object> -required-

    # kubectl explain deployment.spec.strategy.rollingUpdate
    fields :maxSurge,         # <string>
           :maxUnavailable    # <string>

    # kubectl explain deployment.spec.template.spec.containers
    fields :args,                     # <[]string>
           :command,                  # <[]string>
           :env,                      # <[]Object>
           :envFrom,                  # <[]Object>
           :image,                    # <string>
           :imagePullPolicy,          # <string>
           :lifecycle,                # <Object>
           :livenessProbe,            # <Object>
           :containerName,            # <string> -required- (originally called name)
           :ports,                    # <[]Object>
           :readinessProbe,           # <Object>
           :resources,                # <Object>
           :securityContext,          # <Object>
           :startupProbe,             # <Object>
           :stdin,                    # <boolean>
           :stdinOnce,                # <boolean>
           :terminationMessagePath,   # <string>
           :terminationMessagePolicy, # <string>
           :tty,                      # <boolean>
           :volumeDevices,            # <[]Object>
           :volumeMounts,             # <[]Object>
           :workingDir                # <string>

    # kubectl explain deployment.spec.template.spec.containers.ports
   fields :containerPort, # <integer> -required-
          :hostIP,        # <string>
          :hostPort,      # <integer>
          :portName,      # <string> (originally called name)
          :protocol       # <string>

    def default_apiVersion
      "apps/v1"
    end

    def default_spec
      {
        minReadySeconds: minReadySeconds,
        paused: paused,
        progressDeadlineSeconds: progressDeadlineSeconds,
        replicas: replicas,
        revisionHistoryLimit: revisionHistoryLimit,
        selector: selector,
        strategy: strategy,
        template: template,
      }
    end

    def default_replicas
      1
    end

    def default_selector
      { matchLabels: matchLabels }
    end

    def default_matchLabels
      labels
    end

    def default_strategy
      {
        rollingUpdate: {
          maxSurge: maxSurge,
          maxUnavailable: maxUnavailable,
        },
        type: "RollingUpdate",
      }
    end

    def default_maxSurge
      25
    end

    def default_maxUnavailable
      25
    end

    def default_template
      {
        metadata: templateMetadata,
        spec: templateSpec,
      }
    end

    def default_templateSpec
      { containers: containers }
    end

    def default_templateMetadata
      { labels: labels }
    end

    def default_containers
      [container, sidecar].compact
    end

    def default_container
      {
        args: args,
        command: command,
        env: env,
        envFrom: envFrom,
        image: image,
        imagePullPolicy: imagePullPolicy,
        lifecycle: lifecycle,
        livenessProbe: livenessProbe,
        name: containerName || name,
        ports: ports,
        readinessProbe: readinessProbe,
        resources: resources,
        securityContext: securityContext,
        startupProbe: startupProbe,
        stdin: stdin,
        stdinOnce: stdinOnce,
        terminationMessagePath: terminationMessagePath,
        terminationMessagePolicy: terminationMessagePolicy,
        tty: tty,
        volumeDevices: volumeDevices,
        volumeMounts: volumeMounts,
        workingDir: workingDir,
      }
    end

    def default_ports
      [
        containerPort: containerPort,
        hostIP: hostIP,
        hostPort: hostPort,
        name: portName,
        protocol: protocol,
      ]
    end

    # Override command instead of default_command since we want to change a String to an Array
    def command_reader
      @command.is_a?(String) ? @command.split(' ') : @command # else assume Array
    end
  end
end
