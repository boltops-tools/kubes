module Kubes::Compiler::Decorator
  class Write < Base
    def process(item)
      case item['kind']
      when "Deployment"
        Resources::Deployment.new(item).run
      when "Pod"
        Resources::Pod.new(item).run
      else
        item # pass through
      end
    end
  end
end
