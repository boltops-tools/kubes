module Kubes::Compiler::Dsl::Syntax
  class Ingress < Resource
    # kubectl explain ingress.spec
    fields :backend, # <Object>
           :rules,   # <[]Object>
           :tls      # <[]Object>

    # kubectl explain ingress.spec.rules.http
    fields :paths       # <[]Object> -required-

    # kubectl explain ingress.spec.rules.http.paths.backend
    fields :serviceName, # <string> -required-
           :servicePort  # <string> -required-

    def default_apiVersion
      "networking.k8s.io/v1beta1"
    end

    def default_spec
      { rules: rules }
    end

    def default_rules
      [
        http: {
          paths: paths
        }
      ]
    end

    def default_paths
      [
        path: '/*',
        backend: {
          serviceName: serviceName,
          servicePort: servicePort,
        }
      ]
    end
  end
end
