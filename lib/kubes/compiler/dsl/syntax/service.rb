module Kubes::Compiler::Dsl::Syntax
  class Service < Resource
    attribute_methods :clusterIP,
                      :ports,
                      :selector,
                      :type

    def default_apiVersion
      "v1"
    end

    def default_selector
      labels
    end

    def default_spec
      {
        ports: ports,
        selector: selector,
        type: @type || "ClusterIP",
      }
    end

    def default_ports
      port = @port || 80
      protocol = @protocol || "TCP"
      targetPort = @targetPort || 80
      [{port: port, protocol: protocol, targetPort: targetPort}]
    end
  end
end
