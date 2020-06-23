module Kubes::Compiler::Decorator
  class Write
    def initialize(data)
      @data = data
    end

    def result
      case @data['kind']
      when "Deployment"
        Resources::Deployment.new(@data).run
      when "Pod"
        Resources::Pod.new(@data).run
      else
        @data # pass through
      end
    end
  end
end
