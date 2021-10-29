class Kubes::Compiler::Decorator::Hashable
  class Field
    # item is full structure
    #
    #     secretRef:           <--- wrapper_key
    #       name: demo-secret  <--- target_key is 'name' from wrapper_map[wrapper_key]
    #
    attr_reader :item # for debugging
    def initialize(item)
      @item = item
    end

    def hashable?
      x = @item.keys & wrapper_map.keys
      !x.empty?
    end

    def kind
      wrapper_key =~ /configMap/ ? "ConfigMap" : "Secret"
    end

    # The target key of the hashable value is that key used for find value to add hash
    #
    #     envFrom:
    #     - secretRef:             <--- wrapper_key
    #         name: demo-secret    <--- target_key is 'name' from wrapper_map[wrapper_key]
    #
    def target_key
      wrapper_map[wrapper_key]
    end

    # The wrapper field is nested right above the item with the hashable value.
    # Simple example:
    #
    #     envFrom:
    #     - secretRef:           <--- wrapper_key
    #         name: demo-secret  <--- target_key is 'name' from wrapper_map[wrapper_key]
    #
    # More complex example where there's a configMap.name key also on the same level.
    #
    #     volumes:
    #     - name: config-map-volume
    #       configMap:
    #         name: demo-config-map
    #
    # Note: Wont work for case when there's are 2 matching wrapper_map keys,
    # but don't think Kubernetes allows 2 matching wrapper_map keys.
    # Example: This is invalid Kubernetes YAML.
    #
    #     volumes:
    #     - name: config-map-volume
    #       configMap:
    #         name: demo-config-map
    #       secretRef:
    #         name: demo-seret
    def wrapper_key
      @item.keys.find { |k| wrapper_map.keys.include?(k) } # this key used for map[wrapper_key]
    end

    # wrapper element to key that stores the hashable value
    def wrapper_map
      {
        'configMapRef' => 'name',    # containers.env.envFrom.configMapRef.name
        'configMapKeyRef' => 'name', # containers.env.valueFrom.configMapKeyRef.name
        'configMap' => 'name',       # containers.env.envFrom.configMapRef.name
        'secretRef' => 'name',       # containers.env.envFrom.secretRef.name
        'secretKeyRef' => 'name',    # containers.env.valueFrom.secretKeyRef.name
        'secret' => 'secretName',    # volumes.secret.secretName
        'tls' => 'secretName',       # tls.secretName
      }
    end
  end
end
