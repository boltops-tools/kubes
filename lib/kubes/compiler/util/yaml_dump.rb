require "json"
require "yaml"

module Kubes::Compiler::Util
  module YamlDump
    def yaml_dump(data)
      if data.is_a?(Kubes::Compiler::Dsl::Core::Blocks)
        items = data.results.map { |k,v| standardize_yaml(v) }
        items.map(&:to_yaml).join("")
      else
        data = standardize_yaml(data)
        data.to_yaml
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
