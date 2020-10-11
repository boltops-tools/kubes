class Kubes::Compiler::Decorator::Hashable
  class Field
    # item is full wrapper structure
    #
    #     secretRef:  <--- wrapper
    #       name: demo-secret
    #
    def initialize(item)
      @item = item
    end

    def hashable?
      x = @item.keys & map.keys
      !x.empty?
    end

    def kind
      wrapper =~ /configMap/ ? "ConfigMap" : "Secret"
    end

    # The key of the hashable value.
    #
    #     envFrom:
    #     - secretRef:
    #         name: demo-secret    <--- wrapper is 'name'
    #
    def key
      map[wrapper]
    end

    # The wrapper field is nested right above the item with the hashable value.
    #
    #     envFrom:
    #     - secretRef:  <--- wrapper
    #         name: demo-secret
    #
    def wrapper
      @item.keys.first
    end

    # wrapper element to key that stores the hashable value
    def map
      {
        'configMapRef' => 'name',
        'configMapKeyRef' => 'name',
        'configMap' => 'name',
        'secretRef' => 'name',
        'secretKeyRef' => 'name',
        'secret' => 'secretName',
      }
    end
  end
end
