class Kubes::Compiler::Decorator::Resources::Container
  # Nice to group the mapping logic in ones spot, making a pattern of this is not worth it.
  module Mapping
    def deployment_keys
      @containers_key = 'spec.template.spec.containers'
      @volumes_key = 'spec.template.spec.volumes'
    end

    def pod_keys
      @containers_key = 'spec.containers'
      @volumes_key = 'spec.volumes'
    end

    def configMaps_fields
      @envFrom_field = 'configMapRef'
      @valueFrom_field = 'configMapKeyRef'
      @volume_field = 'configMap'
      @volume_field_name = 'name'
    end

    def secrets_fields
      @envFrom_field = 'secretRef'
      @valueFrom_field = 'secretKeyRef'
      @volume_field = 'secret'
      @volume_field_name = 'secretName'
    end
  end
end
