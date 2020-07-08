module Kubes::Compiler::Dsl::Syntax
  class Resource < Kubes::Compiler::Dsl::Core::Base
    include Kubes::Compiler::Util::Normalize
    include Kubes::Compiler::Shared::Helpers

    fields :apiVersion,  # <string>
           :kind,        # <string>
           :metadata,    # <Object>
           :result,      # <Object>
           :spec         # <Object>

    # kubectl explain deployment.metadata
    fields "annotations:hash",  # <map[string]string>
           "labels:hash",       # <map[string]string>
           :namespace           # <string>

    attr_accessor :kind_from_block

    # top-level of resource is quite common
    def default_result
      data = top.merge(
        apiVersion: apiVersion,
        kind: kind,
        metadata: metadata,
        spec: spec,
      )
      data.deeper_merge!(default_result_append)
      data.deep_stringify_keys!
      HashSqueezer.squeeze(data)
    end

    # Where to set fields for generic kind
    def top
      @top ||= {}
    end

    # can be overridden by subclasses. IE: secret
    def default_result_append
      {}
    end

    def default_apiVersion
      "v1"
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
      return @kind_from_block if @kind_from_block
      normalize_kind(@path)
    end
    alias_method :resource_kind, :default_kind

    # For generic kind
    def field(name, data)
      top.deeper_merge!(name => data)
    end
  end
end
