require "json"
require "yaml"

module Kubes::Compiler::Util
  module YamlDump
    def yaml_dump(data)
      if data.key?("kind")  # single resource in YAML
        data = standardize_yaml(data)
        data.to_yaml
      else
        items = data.map { |k,v| standardize_yaml(v) }
        items.map(&:to_yaml).join("")
      end
    end

    # https://stackoverflow.com/questions/24508364/how-to-emit-yaml-in-ruby-expanding-aliases/46104244#46104244
    # Prevents YAML from generating aliases/anchors.
    def standardize_yaml(data)
      json = data.to_json
      YAML.load(json)
    end
  end
end
