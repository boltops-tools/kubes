module Kubes::Compiler::Decorator
  class Compile < Base
    def process(item)
      case item['kind']
      when "ConfigMap", "Secret"
        Resources::Secret.new(item).run
      else
        item # pass through
      end
    end
  end
end
