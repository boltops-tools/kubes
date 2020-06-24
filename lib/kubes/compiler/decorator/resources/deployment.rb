module Kubes::Compiler::Decorator::Resources
  class Deployment < Base
    def perform
      container = Container.new(@data, kind: "Deployment", fields_for: "Secret")
      @data = container.run
      container = Container.new(@data, kind: "Deployment", fields_for: "ConfigMap")
      @data = container.run
    end
  end
end
