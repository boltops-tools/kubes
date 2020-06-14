module Kubes
  class Auth
    def initialize(image)
      @image = image
    end

    def run
      klass = strategy_class
      return unless klass
      klass.new(@image).run
    end

    # Currently only support ECR
    def strategy_class
      case @image
      when /\.amazonaws\.com/ # IE: 112233445566.dkr.ecr.us-west-2.amazonaws.com/demo/sinatra
        Ecr
      end
    end
  end
end
