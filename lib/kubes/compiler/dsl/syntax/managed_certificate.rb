module Kubes::Compiler::Dsl::Syntax
  class ManagedCertificate < Resource
    attribute_methods :domain,
                      :domains

    def default_apiVersion
      "networking.gke.io/v1beta2"
    end

    def default_spec
      { domains: domains }
    end

    def default_domains
      [domain]
    end
  end
end
