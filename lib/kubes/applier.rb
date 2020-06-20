module Kubes
  class Applier
    extend Memoist
    include Kubes::Util::Sh

    def initialize(options={})
      @options = options
    end

    def run
      sorted_files.each do |file|
        Kubes::Kubectl.run(:apply, @options.merge(file: file))
      end
    end

    def sorted_files
      files.sort_by do |file|
        # .kubes/output/demo-web/service.yaml
        words = file.split('/')
        app, resource = words[2], words[3] # demo-web, service
        resource = resource.sub('.yaml','').underscore.camelize
        index = ORDERING.index(resource) || 999
        index = index.to_s.rjust(3, "0") # pad with 0
        "#{app}/#{index}"
      end
    end

    # kubes apply                        # {app: nil, resource: nil}
    # kubes apply demo-clock             # {app: "demo-clock", resource: nil}
    # kubes apply demo-clock deployment  # {app: "demo-clock", resource: "deployment"}
    def search_expr
      app, resource = @options[:app], @options[:resource]
      if app && resource
        "#{Kubes.root}/.kubes/output/#{app}/#{resource}.yaml"
      elsif app
        "#{Kubes.root}/.kubes/output/#{app}/*"
      else
        "#{Kubes.root}/.kubes/output/**/*"
      end
    end

    def files
      files = []
      Dir.glob(search_expr).each do |path|
        next unless File.file?(path)
        file = path.sub("#{Kubes.root}/", '')
        files << file
      end
      files
    end

    # Create resources in specific order so dependent resources are available
    ORDERING = %w[
      Namespace
      StorageClass
      CustomResourceDefinition
      MutatingWebhookConfiguration
      ServiceAccount
      PodSecurityPolicy
      Role
      ClusterRole
      RoleBinding
      ClusterRoleBinding
      ConfigMap
      Secret
      LimitRange
      Deployment
      Service
      StatefulSet
      CronJob
      PodDisruptionBudget
    ]
  end
end
