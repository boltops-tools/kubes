module Kubes::Compiler::Dsl::Syntax
  class ConfigMap < Resource
    include Kubes::Compiler::Dsl::Core::Files

    # kubectl explain secret
    fields "data:hash",        # <map[string]string>
           "binaryData:hash"   # <map[string]string>

    def default_apiVersion
      "v1"
    end

    def default_result_append
      {
        data: data,
        binaryData: binaryData,
      }
    end
  end
end
