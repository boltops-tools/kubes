module Kubes::Compiler::Decorator::Resources
  class Container
    include Mapping

    def initialize(data, kind:, fields_for:)
      @data = data
      # These methods are defined in Mapping
      kind == "Deployment" ? deployment_keys : pod_keys
      fields_for == "Secret" ? secrets_fields : configMaps_fields
    end

    def run
      envFrom!
      valueFrom!
      volumes!
      @data
    end

    # spec.envFrom.configMapRef
    # spec.envFrom.secretRef
    def envFrom!
      return @data unless containers

      containers.each do |container|
        next unless envFrom_list = container.dig('envFrom') # intentional assignment

        envFrom_list.each do |envFrom|
          next unless name = envFrom.dig(@envFrom_field, 'name') # intentional assignment

          md5 = Kubes::Compiler::Decorator.fetch(name)
          envFrom[@envFrom_field]['name'] = [name, md5].compact.join('-')
        end
      end
    end

    # spec.valueFrom.configMapKeyRef
    # spec.valueFrom.secretKeyRef
    def valueFrom!
      return @data unless containers

      containers.each do |container|
        next unless env_list = container.dig('env') # intentional assignment

        env_list.each do |env|
          next unless name = env.dig('valueFrom',@valueFrom_field,'name') # intentional assignment

          md5 = Kubes::Compiler::Decorator.fetch(name)
          env['valueFrom'][@valueFrom_field]['name'] = [name, md5].compact.join('-')
        end
      end
    end

    # spec.volumes.configMap.name
    # spec.volumes.secret.secretName
    def volumes!
      volumes = @data.dig(*@volumes_key.split('.'))
      return @data unless volumes

      volumes.each do |volume|
        # Example:
        # next unless field = volume.dig('secret') # intentional assignment
        # next unless name = field['secretName'] # intentional assignment
        next unless field = volume.dig(@volume_field) # intentional assignment
        next unless name = field[@volume_field_name] # intentional assignment

        md5 = Kubes::Compiler::Decorator.fetch(name)
        field[@volume_field_name] = [name, md5].compact.join('-')
      end
    end

  private
    def containers
      @data.dig(*@containers_key.split('.'))
    end
  end
end
