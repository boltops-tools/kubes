module Kubes::Compiler::Dsl::Syntax
  class Ingress < Resource
    attr_reader :paths
    setter_methods :rules, :paths

    def default_api_version
      "networking.k8s.io/v1beta1"
    end

    def top_spec
      {
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
