module Kubes::Compiler::Decorator::Resources
  class Pod < Base
    def perform
      container = Container.new(@data, kind: "Pod", fields_for: "Secret")
      @data = container.run
      container = Container.new(@data, kind: "Pod", fields_for: "ConfigMap")
      @data = container.run
    end
  end
end
