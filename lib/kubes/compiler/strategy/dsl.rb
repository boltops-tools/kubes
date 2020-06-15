class Kubes::Compiler::Strategy
  class Dsl < Base
    def run
      klass = syntax_class
      syntax = klass.new(@options) # Deployment, Service, etc
      yaml = syntax.run
      Result.new(@save_file, yaml)
    end

    def syntax_class
      # Remove .kubes/resources
      klass_name = File.basename(@filename).sub('.rb','').underscore.camelize # Deployment, Service, Ingress, ManagedCertificate, etc
      klass_name = klass_map(klass_name)
      "Kubes::Compiler::Dsl::Syntax::#{klass_name}".constantize
    rescue NameError => e
      file = ".kubes/resources/#{klass_name.underscore}"
      logger.debug "#{e.class}: #{e.message}"
      logger.error "ERROR: DSL syntax is not supported for this resource type: #{klass_name}".color(:red)
      logger.error <<~EOL
        The DSL does not support: #{file}.rb
        Try using YAML instead: #{file}.yaml
      EOL
      exit 1
    end

    # Allows user to name the files:
    #
    #   managedcertificate => managed_certificate
    #
    def klass_map(klass_name)
      map = {
        Backendconfig: "BackendConfig",
        Managedcertificate: "ManagedCertificate",
      }
      map[klass_name.to_sym] || klass_name
    end
  end
end
