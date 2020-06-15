module Kubes::Compiler::Dsl::Syntax
  class BackendConfig < Resource
    setting_methods :domains, :domain

    def default_api_version
      "cloud.google.com/v1"
    end
  end
end
