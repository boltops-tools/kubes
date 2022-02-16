module Kubes::Compiler::Shared::Helpers
  module ConfigMapHelper
    def config_map_files(options={})
      indent = options[:indent] || 2

      shared_config_map = "#{Kubes.root}/.kubes/resources/shared/config_map"
      layers = [
        [shared_config_map, "base.txt"],
        [shared_config_map, "#{Kubes.env}.txt"],
      ]
      if Kubes.app
        layers += [
          [shared_config_map, Kubes.app, "base.txt"],
          [shared_config_map, Kubes.app, "#{Kubes.env}.txt"],
        ]
      end
      layers.map! { |layer| layer.compact.join('/') }
      data = {}
      layers.each do |path|
        next unless File.exist?(path)
        lines = IO.readlines(path)
        lines.each do |line|
          key, value = line.split('=').map(&:strip)
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
