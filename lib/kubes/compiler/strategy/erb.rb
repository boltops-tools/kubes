require "deep_merge/rails_compat"
require "render_me_pretty"

class Kubes::Compiler::Strategy
  class Erb < Base
    include Kubes::Compiler::Dsl::Core::Helpers

    def run
      data = render(@path)
      layers.each do |path|
        layer = render(path)
        data.deeper_merge!(layer)
      end
      yaml = YAML.dump(data)
      Result.new(@save_file, yaml)
    end

    def render(path)
      if File.exist?(path)
        yaml = RenderMePretty.result(path, context: self)
        YAML.load(yaml)
      else
        {}
      end
    end
  end
end
