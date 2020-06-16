module Kubes::Compiler::Dsl::Syntax
  class Ingress < Resource
    attribute_methods :rules, :paths

    def default_api_version
      "networking.k8s.io/v1beta1"
    end

    def spec
      @spec || {
        rules: rules,
      }
    end

    def rules
      @rules || default_rules
    end

    def default_rules
      [
        http: {
          paths: paths
        }
      ]
    end
  end
end
