module Kubes::Compiler::Dsl::Syntax
  class Service < Resource
    setting_methods :selector, :type, :clusterIP

    def default_api_version
      "v1"
    end

    def selector
      @selector || labels
    end

    def top_spec
      {
        ports: ports,
        selector: selector,
        type: @type || "ClusterIP",
      }
    end

    def selector
      @selector || labels
    end

    def ports
      return @ports if @ports

      port = @port || 80
      protocol = @protocol || "TCP"
      targetPort = @targetPort || 80
      [{port: port, protocol: protocol, targetPort: targetPort}]
    end
  end
end
