class Kubes::Compiler
  module Layering
    def pre_layers
      return [] if Kubes.kustomize?

      ext = File.extname(@path)
      kind = File.basename(@path).sub(ext,'') # IE: deployment
      kind = kind.pluralize if @block_form
      role = @path.split('/')[-2] # .kubes/resources/web/deployment.yaml
      layers = [
        "base/all",
        "base/all/#{Kubes.env}",
        "base/#{kind}",
        "base/#{kind}/#{Kubes.env}",
        "#{role}/all",
      ]
      layers = add_exts(layers)
      layers.map! do |layer|
        "#{Kubes.root}/.kubes/resources/#{layer}"
      end
      layers.select { |layer| File.exist?(layer) }
    end

    def post_layers
      return [] if Kubes.kustomize?

      ext = File.extname(@path)
      kind_path = @path.sub(ext,'')

      layers = [
        "base",
        Kubes.env.to_s
      ]

      if Kubes.app
        layers += [
          Kubes.app,
          "#{Kubes.app}/base",
          "#{Kubes.app}/#{Kubes.env}",
        ]
      end

      layers = add_exts(layers)
      layers.map! do |layer|
        "#{kind_path}/#{layer}"
      end
      layers.select { |layer| File.exist?(layer) }
    end

    def add_exts(*layers)
      layers.flatten.map do |layer|
        [
          "#{layer}.rb",
          "#{layer}.yaml",
          "#{layer}.yml",
        ]
      end.flatten
    end
  end
end
