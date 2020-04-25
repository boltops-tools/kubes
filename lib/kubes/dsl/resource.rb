module Kubes::Dsl
  class Resource < Base
    extend MetaMethods

    attr_reader :labels
    setter_methods :resource, :metadata, :kind, :labels

    # top-level of resource is quite common
    def resource
      resource = @resource || {
        apiVersion: @apiVersion || default_api_version,
        kind: kind,
        metadata: metadata,
        spec: spec,
      }.deep_stringify_keys
      data = HashSqueezer.squeeze(resource)
      YAML.dump(data)
    end
    alias_method :build, :resource

    def metadata
      @metadata || default_metadata
    end

    def spec
      @spec || default_spec
    end

    def default_metadata
      props = {
        name: @name,
      }
      props[:labels] = labels
      props[:namespace] = @namespace
      props
    end

    def kind
      @kind || self.class.to_s.split('::').last # IE: Deployment
    end
  end
end
