module Kubes
  module Plugin
    @@plugins = []
    def plugins
      @@plugins
    end

    def register(klass)
      @@plugins << klass
    end

    extend self
  end
end
