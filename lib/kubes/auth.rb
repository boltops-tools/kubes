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

    # Currently only support ECR and GCR
    # TODO: consider moving this to plugin gems
    def strategy_class
      case @image
      when /\.amazonaws\.com/ # IE: 112233445566.dkr.ecr.us-west-2.amazonaws.com/demo/sinatra
        Ecr
      when /gcr\.io/
        Gcr
      end
    end
  end
end
