module Kubes::Dsl::Evaluator
  class Resource < Base
    extend MetaMethods

    setter_methods :resource, :metadata, :kind

    # top-level of resource is quite common
    def resource
      @resource = {
        apiVersion: "apps/v1",
        kind: kind,
        metadata: metadata,
        spec: spec,
      }.deep_stringify_keys
    end
    alias_method :build, :resource

    def metadata
      @metadata || {
        name: @name,
        labels: @labels,
        namespace: @namespace
      }
    end

    def kind
      @kind || self.class.to_s.split('::').last # IE: Deployment
    end
  end
end
