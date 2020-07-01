module Kubes::Compiler::Dsl::Syntax
  class NetworkPolicy < Resource
    fields :egress,       # <[]Object>
           :ingress,      # <[]Object>
           :podSelector,  # <Object> -required-
           :policyTypes   # <[]string>

    fields "fromMatchLabels:hash",
           "matchLabels:hash"

    def default_apiVersion
      "networking.k8s.io/v1"
    end

    def default_spec
      {
        podSelector: {
          matchLabels: matchLabels
        },
        ingress: [
          from: [
            podSelector: {
              matchLabels: fromMatchLabels
            }
          ]
        ]
      }
    end
  end
end
