module Kubes::Docker
  class Base
    include Kubes::Logging
    include Kubes::Util::Sh

    def initialize(options={})
      @options = options
    end

    def run_hooks(name, &block)
      hooks = Kubes::Hooks::Builder.new(name, "#{Kubes.root}/.kubes/config/docker/hooks.rb")
      hooks.build # build hooks
      hooks.run_hooks(&block)
    end
  end
end
