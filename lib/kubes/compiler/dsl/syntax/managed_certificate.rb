module Kubes::Compiler::Dsl::Syntax
  class ManagedCertificate < Resource
    setting_methods :domains, :domain

    def default_api_version
      "networking.gke.io/v1beta2"
    end

    def top_spec
      {
        domains: domains,
      }
    end

    def domains
      @domains ||= [domain]
    end
  end
end
