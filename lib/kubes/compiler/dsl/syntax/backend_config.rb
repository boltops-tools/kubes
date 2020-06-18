module Kubes::Compiler::Dsl::Syntax
  class BackendConfig < Resource
    attribute_methods :domain,
                      :domains

    def default_apiVersion
      "cloud.google.com/v1"
    end
  end
end
