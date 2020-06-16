module Kubes::Compiler::Dsl::Syntax
  class ManagedCertificate < Resource
    attribute_methods :domains, :domain

    def default_api_version
      "networking.gke.io/v1beta2"
    end

    def spec
      @spec || {
        domains: domains,
      }
    end

    def domains
      @domains ||= [domain]
    end
  end
end
