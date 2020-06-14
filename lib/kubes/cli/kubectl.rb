class Kubes::CLI
  class Kubectl
    extend Memoist
    include Kubes::Util::Sh

    def initialize(name, options={})
      @name, @options = name, options
    end

    def run
      params = args.flatten.join(' ')
      command = "kubectl #{@name} #{params}"
      run_hooks(@name) do
        sh(command)
      end
    end

    def run_hooks(name, &block)
      hooks = Hooks::Builder.new(@mod, name)
      hooks.build # build hooks
      hooks.run_hooks(&block)
    end

    def args
      # base at end in case of redirection. IE: command > /path
      custom.args + default.args
    end

    def custom
      custom = Args::Custom.new(@name)
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

