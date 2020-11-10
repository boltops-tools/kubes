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
      return unless auth?
      case @image
      when /\.amazonaws\.com/ # IE: 112233445566.dkr.ecr.us-west-2.amazonaws.com/demo/sinatra
        Ecr
      when /gcr\.io/
        Gcr
      end
    end

    def auth?
      if ENV['KUBES_REPO_AUTO_AUTH'].nil?
        Kubes.config.repo_auth
      else
        %w[1 true].include?(ENV['KUBES_REPO_AUTO_AUTH'])
      end
    end
  end
end
