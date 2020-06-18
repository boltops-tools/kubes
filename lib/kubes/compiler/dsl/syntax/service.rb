module Kubes::Compiler::Dsl::Syntax
  class Service < Resource
    attribute_methods :clusterIP,
                      :port,
                      :ports,
                      :protocol,
                      :selector,
                      :targetPort,
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
        type: type,
      }
    end

    def default_type
      "ClusterIP"
    end

    def default_ports
      [
        port: port,
        protocol: protocol,
        targetPort: targetPort
      ]
    end

    def default_port
      80
    end

    def default_protocol
      "TCP"
    end

    def default_targetPort
      80
    end
  end
end
