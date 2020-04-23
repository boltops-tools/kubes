module Kubes::Dsl::Evaluator
  class Resource < Base
    extend MetaMethods

    setter_methods :resource, :metadata, :kind

    # top-level of resource is quite common
    def resource
      resource = @resource || {
        apiVersion: @api_version || "apps/v1",
        kind: kind,
        metadata: metadata,
        spec: spec,
      }.deep_stringify_keys
      HashSqueezer.new(resource).squeeze
    end
    alias_method :build, :resource

    def metadata
      @metadata || default_metadata
    end

    def default_metadata
      props = {
        name: @name,
      }
      props[:labels] = @labels if @labels
      props[:namespace] = @namespace if @namespace
      props
    end

    def kind
      @kind || self.class.to_s.split('::').last # IE: Deployment
    end
  end
end
