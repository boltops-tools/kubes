module Kubes::Compiler::Dsl::Syntax
  class Resource < Kubes::Compiler::Dsl::Core::Base
    setting_methods :apiVersion, :resource, :metadata, :kind, :labels

    # top-level of resource is quite common
    def resource
      resource = @resource || {
        apiVersion: apiVersion,
        kind: kind,
        metadata: metadata,
        spec: spec,
      }.deep_stringify_keys
      data = HashSqueezer.squeeze(resource)
      YAML.dump(data)
    end

    def apiVersion
      @apiVersion || default_api_version
    end

    def metadata
      @metadata || default_metadata
    end

    def spec
      @spec || top_spec
    end

    def top_spec
      {}
    end

    def default_metadata
      {
        name: @name,
        labels: labels,
        namespace: @namespace,
      }
    end

    def kind
      @kind || self.class.to_s.split('::').last # IE: Deployment
    end
  end
end
