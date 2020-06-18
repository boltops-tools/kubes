module Kubes
  class Kubectl
    extend Memoist
    include Kubes::Util::Sh

    def initialize(name, options={})
      @name, @options = name, options
    end

    def run
      params = args.flatten.join(' ')
      command = "kubectl #{@name} #{params}"
      switch_context do
        run_hooks(@name) do
          sh(command)
        end
      end
    end

    def switch_context(&block)
      kubectl = Kubes.config.kubectl
      context = kubectl.context # intentional assignment
      if context
        previous_context = capture("kubectl config current-context")
        sh("kubectl config use-context #{context}", mute: true)
        result = block.call
        if previous_context != "" && !kubectl.context_keep
          sh("kubectl config use-context #{previous_context}", mute: true)
        end
        result
      else
        block.call
      end
    end

    def run_hooks(name, &block)
      hooks = Kubes::Hooks::Builder.new(name, "#{Kubes.root}/.kubes/config/kubectl/hooks.rb")
      hooks.build # build hooks
      hooks.run_hooks(&block)
    end

    def args
      # base at end in case of redirection. IE: command > /path
      custom.args + default.args
    end

    def custom
      custom = Kubes::Args::Custom.new(@name, "#{Kubes.root}/.kubes/config/kubectl/args.rb")
      custom.build
      custom
    end
    memoize :custom

    def default
      Args::Default.new(@name, @options)
    end
    memoize :default

    class << self
      def run(name, options={})
        new(name, options).run
      end
    end
  end
end

