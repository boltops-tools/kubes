module Kubes::Compiler::Dsl::Syntax
  class Ingress < Resource
    field_methods :paths,
                  :serviceName,
                  :servicePort

    # kubectl explain ingress.spec
    field_methods :backend, # <Object>
                  :rules,   # <[]Object>
                  :tls      # <[]Object>

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
