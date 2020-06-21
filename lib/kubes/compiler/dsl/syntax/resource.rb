module Kubes::Compiler::Dsl::Syntax
  class Resource < Kubes::Compiler::Dsl::Core::Base
    include Kubes::Compiler::Shared::Helpers
    include Kubes::Util::YamlDump
    fields :apiVersion,  # <string>
           :kind,        # <string>
           :metadata,    # <Object>
           :resource,    # <Object>
           :spec         # <Object>

    # kubectl explain deployment.metadata
    fields "annotations:hash",  # <map[string]string>
           "labels:hash",       # <map[string]string>
           :namespace           # <string>

    # top-level of resource is quite common
    def default_resource
      data = {
        apiVersion: apiVersion,
        kind: kind,
        metadata: metadata,
        spec: spec,
      }
      data.merge!(default_resource_append)
      data.deep_stringify_keys!
      data = HashSqueezer.squeeze(data)
      yaml_dump(data)
    end

    # can be overridden by subclasses. IE: secret
    def default_resource_append
      {}
    end

    def default_metadata
      {
        annotations: annotations,
        name: name,
        labels: labels,
        namespace: namespace,
      }
    end

    def default_kind
      self.class.to_s.split('::').last # IE: Deployment
    end
    alias_method :resource_kind, :default_kind
  end
end
