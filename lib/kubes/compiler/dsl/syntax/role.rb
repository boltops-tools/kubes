module Kubes::Compiler::Dsl::Syntax
  class Role < Resource
    fields :rules         # <[]Object>

    # kubectl explain role.rules
    fields :apiGroups,       # <[]string>
           :nonResourceURLs, # <[]string>
           :resourceNames,   # <[]string>
           :resources,       # <[]string>
           :verbs            # <[]string> -required-

    def apiVersion
      "rbac.authorization.k8s.io/v1"
    end

    # override superclass method - no spec
    def default_top
      {
        apiVersion: apiVersion,
        kind: kind,
        metadata: metadata,
        rules: rules,
      }
    end

    def default_rules
      [default_rule]
    end

    def default_rule
      {
        apiGroups: apiGroups,
        nonResourceURLs: nonResourceURLs,
        resourceNames: resourceNames,
        resources: resources,
        verbs: verbs,
      }
    end
  end
end
