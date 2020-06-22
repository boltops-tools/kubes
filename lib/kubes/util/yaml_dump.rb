require "json"
require "yaml"

module Kubes::Util
  module YamlDump
    # https://stackoverflow.com/questions/24508364/how-to-emit-yaml-in-ruby-expanding-aliases/46104244#46104244
    def yaml_dump(data)
      json = data.to_json
      data = YAML.load(json)
      data.to_yaml
    end
  end
end
