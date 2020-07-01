class Kubes::Compiler
  module Layering
    def pre_layers
      return [] if Kubes.kustomize?

      ext = File.extname(@path)
      kind = File.basename(@path).sub(ext,'') # IE: deployment
      layers = [
        "all#{ext}",
        "all/#{Kubes.env}#{ext}",
        "#{kind}#{ext}",
        "#{kind}/#{Kubes.env}#{ext}",
      ]
      layers.map do |layer|
        "#{Kubes.root}/.kubes/resources/base/#{layer}"
      end
    end

    def post_layers
      return [] if Kubes.kustomize?

      ext = File.extname(@path)
      kind_path = @path.sub(ext,'')

      layers = [
        "base",
        Kubes.env.to_s
      ]
      layers.map do |layer|
        "#{kind_path}/#{layer}#{ext}"
      end
    end
  end
end
