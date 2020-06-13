class Kubes::Compiler
  module Layering
    def layers
      ext = File.extname(@path)
      resource_folder = @path.sub(ext,'')
      layer_names.map do |name|
        "#{resource_folder}/#{name}#{ext}"
      end
    end

    def layer_names
      ["base", Kubes.env.to_s]
    end
  end
end
