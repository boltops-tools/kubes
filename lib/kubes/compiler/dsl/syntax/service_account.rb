module Kubes::Compiler::Dsl::Syntax
  class ServiceAccount < Resource
    # kubectl explain serviceaccount
    fields :automountServiceAccountToken, # <boolean>
           :imagePullSecrets,             # <[]Object>
           :secrets                       # <[]Object>

    # override superclass method - no spec
    def default_top
      {
        apiVersion: apiVersion,
        kind: kind,
        metadata: metadata,
        automountServiceAccountToken: automountServiceAccountToken,
        imagePullSecrets: imagePullSecrets,
        secrets: secrets,
      }
    end
  end
end
