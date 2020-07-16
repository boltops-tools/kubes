module Kubes::Compiler::Dsl::Syntax
  class NetworkPolicy < Resource
    fields :egress,       # <[]Object>
           :ingress,      # <[]Object>
           :podSelector,  # <Object> -required-
           :policyTypes   # <[]string>

    fields "matchLabels:hash"

    fields "fromNamespace:hash",
           "fromPod:hash",
           "fromIpBlock:hash",
           "toNamespace:hash",
           "toPod:hash",
           "toIpBlock:hash",
           :from,
           :to

    def default_apiVersion
      "networking.k8s.io/v1"
    end

    def default_spec
      {
        podSelector: { matchLabels: matchLabels },
        ingress: [from: from],
        egress: [to: to],
      }
    end

    def default_from
      [
        { namespaceSelector: { matchLabels: fromNamespace } },
        { podSelector: { matchLabels: fromPod } },
        { ipBlock: fromIpBlock }
      ]
    end

    def default_to
      [
        { namespaceSelector: { matchLabels: toNamespace } },
        { podSelector: { matchLabels: toPod } },
        { ipBlock: toIpBlock }
      ]
    end
  end
end
