module Kubes::Docker::Strategy
  module Hooks
    def run_hooks(name, &block)
      hooks = Kubes::Hooks::Builder.new(name, "#{Kubes.root}/.kubes/config/docker/hooks.rb")
      hooks.build # build hooks
      hooks.run_hooks(&block)
    end
  end
end
