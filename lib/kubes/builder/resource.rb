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
      }
    end

    def metadata
      {
        name: @name,
        labels: @labels,
        namespace: @namespace
      }
    end

    def kind
      File.basename(self.class.to_s) # IE: Deployment
    end

    def assign_instance_variables(vars)
      vars.each do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
  end
end
