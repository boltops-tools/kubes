module Kubes::Compiler::Decorator
  class Pre < Base
    def process
      case @data['kind']
      when "ConfigMap", "Secret"
        Hashable.new(@data).store
      else
        @data # passthrough
      end
    end
  end
end
