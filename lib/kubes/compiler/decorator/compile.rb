module Kubes::Compiler::Decorator
  class Compile
    def initialize(data)
      @data = data
    end

    def result
      case @data['kind']
      when "ConfigMap", "Secret"
        Resources::Secret.new(@data).run
      else
        @data # pass through
      end
    end
  end
end
