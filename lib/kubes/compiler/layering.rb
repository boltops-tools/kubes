class Kubes::Compiler
  module Layering
    def pre_layers
      return [] if Kubes.kustomize?

      ext = File.extname(@path)
      kind = File.basename(@path).sub(ext,'') # IE: deployment
      all = "all"
      if @block_form
        kind = kind.pluralize
        all = all.pluralize
      end
      layers = [
        "#{all}",
        "#{all}/#{Kubes.env}",
        "#{kind}",
        "#{kind}/#{Kubes.env}",
      ]
      layers = add_exts(layers)
      layers.map! do |layer|
        "#{Kubes.root}/.kubes/resources/base/#{layer}"
      end
      layers.select { |layer| File.exist?(layer) }
    end

    def add_exts(layers)
      layers.map do |layer|
        [
          "#{layer}.rb",
          "#{layer}.yaml",
          "#{layer}.yml",
        ]
      end.flatten
    end

    def post_layers
      return [] if Kubes.kustomize?

      ext = File.extname(@path)
      kind_path = @path.sub(ext,'')

      layers = [
        "base",
        Kubes.env.to_s
      ]
      layers = add_exts(layers)
      layers.map! do |layer|
        "#{kind_path}/#{layer}"
      end
      layers.select { |layer| File.exist?(layer) }
    end
  end
end
