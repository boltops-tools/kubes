module Kubes::Compiler::Shared::Helpers
  module ConfigMapHelper
    def config_map_files(options={})
      indent = options[:indent] || 2
      # /path/to/app/.kubes/resources/shared/config_map.yaml:7:in `__tilt_4660'
      line = caller[0]
      path = line.split(':').first
      basename = File.basename(path).sub(/.erb$/,'').sub(/.yaml$/, '').sub(/.rb$/, '')
      filename = options[:name] || basename

      shared_config_map = "#{Kubes.root}/.kubes/resources/shared/#{filename}"
      layers = [
        [shared_config_map, "base.txt"],
        [shared_config_map, "#{Kubes.env}.txt"],
      ]
      if Kubes.app
        layers += [
          [shared_config_map, "#{Kubes.app}.txt"],
          [shared_config_map, Kubes.app, "base.txt"],
          [shared_config_map, Kubes.app, "#{Kubes.env}.txt"],
        ]
      end
      layers.map! { |layer| layer.compact.join('/') }
      data = {}
      layers.each do |path|
        next unless File.exist?(path)
        text = RenderMePretty.result(path, context: self)
        lines = text.split("\n")
        lines.each do |line|
          key, value = parse_env_like_line(line)
          data[key] = value
        end
      end

      spacing = " " * indent
      lines = data.map do |key,value|
        "#{spacing}#{key}: #{value}"
      end
      lines.join("\n")
    end
  end
end
