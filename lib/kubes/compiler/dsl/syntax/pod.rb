module Kubes::Compiler::Dsl::Syntax
  class Pod < Resource
     fields :activeDeadlineSeconds,         # <integer>
            :affinity,                      # <Object>
            :automountServiceAccountToken,  # <boolean>
            :containers,                    # <[]Object> -required-
            :dnsConfig,                     # <Object>
            :dnsPolicy,                     # <string>
            :enableServiceLinks,            # <boolean>
            :ephemeralContainers,           # <[]Object>
            :hostAliases,                   # <[]Object>
            :hostIPC,                       # <boolean>
            :hostNetwork,                   # <boolean>
            :hostPID,                       # <boolean>
            :hostname,                      # <string>
            :imagePullSecrets,              # <[]Object>
            :initContainers,                # <[]Object>
            :nodeName,                      # <string>
            :nodeSelector,                  # <map[string]string>
            :overhead,                      # <map[string]string>
            :preemptionPolicy,              # <string>
            :priority,                      # <integer>
            :priorityClassName,             # <string>
            :readinessGates,                # <[]Object>
            :restartPolicy,                 # <string>
            :runtimeClassName,              # <string>
            :schedulerName,                 # <string>
            :securityContext,               # <Object>
            :serviceAccount,                # <string>
            :serviceAccountName,            # <string>
            :shareProcessNamespace,         # <boolean>
            :subdomain,                     # <string>
            :terminationGracePeriodSeconds, # <integer>
            :tolerations,                   # <[]Object>
            :topologySpreadConstraints,     # <[]Object>
            :volumes                        # <[]Object>

    def default_apiVersion
      "v1"
    end

    def default_spec
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
  end
end
