module Kubes::Compiler::Dsl::Syntax
  class BackendConfig < Resource
    attribute_methods :domains, :domain

    def default_api_version
      "cloud.google.com/v1"
    end
  end
end
