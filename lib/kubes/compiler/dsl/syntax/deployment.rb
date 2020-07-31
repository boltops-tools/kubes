module Kubes::Compiler::Dsl::Syntax
  class Deployment < Resource
    fields :container,          # <Object>
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

    # kubectl explain deploy.spec.template.spec
    fields :activeDeadlineSeconds,        # <integer>
           :affinity,                     # <Object>
           :automountServiceAccountToken, # <boolean>
           :containers,                   # <[]Object> -required-
           :dnsConfig,                    # <Object>
           :dnsPolicy,                    # <string>
           :enableServiceLinks,           # <boolean>
           :ephemeralContainers,          # <[]Object>
           :hostAliases,                  # <[]Object>
           :hostIPC,                      # <boolean>
           :hostNetwork,                  # <boolean>
           :hostPID,                      # <boolean>
           :hostname,                     # <string>
           :imagePullSecrets,             # <[]Object>
           :initContainers,               # <[]Object>
           :nodeName,                     # <string>
           :nodeSelector,                 # <map[string]string>
           :overhead,                     # <map[string]string>
           :preemptionPolicy,             # <string>
           :priority,                     # <integer>
           :priorityClassName,            # <string>
           :readinessGates,               # <[]Object>
           :restartPolicy,                # <string>
           :runtimeClassName,             # <string>
           :schedulerName,                # <string>
           :securityContext,              # <Object>
           :serviceAccount,               # <string>
           :serviceAccountName,           # <string>
           :shareProcessNamespace,        # <boolean>
           :subdomain,                    # <string>
           :terminationGracePeriodSeconds,# <integer>
           :tolerations,                  # <[]Object>
           :topologySpreadConstraints,    # <[]Object>
           :volumes                       # <[]Object>

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
      return unless maxUnavailable || maxSurge

      maxSurge = maxUnavailable if maxUnavailable && !maxSurge
      maxUnavailable = maxSurge if !maxUnavailable && maxSurge

      {
        rollingUpdate: {
          maxSurge: maxSurge,
          maxUnavailable: maxUnavailable,
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
        activeDeadlineSeconds: activeDeadlineSeconds,
        affinity: affinity,
        automountServiceAccountToken: automountServiceAccountToken,
        containers: containers,
        dnsConfig: dnsConfig,
        dnsPolicy: dnsPolicy,
        enableServiceLinks: enableServiceLinks,
        ephemeralContainers: ephemeralContainers,
        hostAliases: hostAliases,
        hostIPC: hostIPC,
        hostNetwork: hostNetwork,
        hostPID: hostPID,
        hostname: hostname,
        imagePullSecrets: imagePullSecrets,
        initContainers: initContainers,
        nodeName: nodeName,
        nodeSelector: nodeSelector,
        overhead: overhead,
        preemptionPolicy: preemptionPolicy,
        priority: priority,
        priorityClassName: priorityClassName,
        readinessGates: readinessGates,
        restartPolicy: restartPolicy,
        runtimeClassName: runtimeClassName,
        schedulerName: schedulerName,
        securityContext: securityContext,
        serviceAccount: serviceAccount,
        serviceAccountName: serviceAccountName,
        shareProcessNamespace: shareProcessNamespace,
        subdomain: subdomain,
        terminationGracePeriodSeconds: terminationGracePeriodSeconds,
        tolerations: tolerations,
        topologySpreadConstraints: topologySpreadConstraints,
        volumes: volumes,
      }
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
