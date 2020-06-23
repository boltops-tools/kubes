module Kubes::Compiler::Dsl::Syntax
  class Secret < Resource
    include Kubes::Compiler::Dsl::Core::Files

    # kubectl explain secret
    fields "data:hash",        # <map[string]string>
           "stringData:hash",  # <map[string]string>
           :type         # <string>

    def default_apiVersion
      "v1"
    end

    def default_resource_append
      {
        data: data,
        stringData: stringData,
        type: type,
      }
    end
  end
end
