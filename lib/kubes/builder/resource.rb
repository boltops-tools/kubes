module Kubes::Builder
  class Resource
    def initialize(vars={})
      assign_instance_variables(vars)
    end

    # top-level of resource is quite common
    def build
      {
        apiVersion: "apps/v1",
        kind: kind,
        metadata: metadata,
        spec: spec,
      }.deep_stringify_keys
    end

    def metadata
      {
        name: @name,
        labels: @labels,
        namespace: @namespace
      }
    end

    def kind
      kind = self.class.to_s.sub("Kubes::Builder::", "")
      File.basename(kind) # IE: Deployment
    end

    def assign_instance_variables(vars)
      vars.each do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
  end
end
