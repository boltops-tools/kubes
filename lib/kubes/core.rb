module Kubes
  module Core
    extend Memoist

    def config
      config = Config.new
      config.evaluate
      config
    end
    memoize :config

    def root
      ENV['KUBES_ROOT'] || Dir.pwd
    end

    def env
      ENV['KUBES_ENV'] || "dev"
    end

    @@logger = nil
    def logger
      return @@logger if @@logger
      @@logger = Logger.new($stdout)
      @@logger.level = ENV['KUBES_LOG_LEVEL'] || 'info'
      @@logger
    end

    def logger=(v)
      @@logger = v
    end
  end
end
