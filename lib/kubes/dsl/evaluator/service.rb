module Kubes::Dsl::Evaluator
  class Service < Resource
    def default_api_version
      "v1"
    end

    def selector
      @selector || labels
    end

    def default_spec
      [
        protocol: @protocol || "TCP",
        port: @port || 80,
        targetPort: @target_port || 80,
      ]
    end
  end
end
