module Kubes
  module Core
    extend Memoist

    def env
      ENV['KUBES_ENV'] || "dev"
    end

    def root
      ENV['KUBES_ROOT'] || Dir.pwd
    end

    def configure(&block)
      Config.instance.configure(&block)
    end

    def config
      Config.instance.load_configs
      Config.instance.config
    end
    memoize :config

    def logger
      config.logger
    end
    memoize :logger

    def kustomize?
      Kubectl::Kustomize.detect?
    end
  end
end
