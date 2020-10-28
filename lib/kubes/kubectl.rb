module Kubes
  class Kubectl
    extend Memoist
    include Kubes::Util::Sh
    include Kubes::Hooks::Concern

    def initialize(name, options={})
      @name, @options = name, options
    end

    def run
      validate!

      options = @options.dup
      options[:exit_on_fail] = exit_on_fail unless exit_on_fail.nil?

      params = args.flatten.join(' ')
      args = "#{@name} #{params}" # @name: apply or delete

      switch_context do
        run_hooks("kubectl.rb", name: @name, file: @options[:file]) do
          if options[:capture]
            self.class.capture(args, options) # already includes kubectl
          else
            self.class.execute(args, options)
          end
        end
      end
    end

    # Useful for kustomize mode
    def validate!
      return true unless Kubes.kustomize?

      unless @options[:role]
        logger.error "Missing argument: A folder must be provided when using kustomization.yaml files".color(:red)
        logger.info "Please provide a folder"
        exit 1
      end
    end

    def exit_on_fail
      return false if ENV['KUBES_EXIT_ON_FAIL'] == '0'
      Kubes.config.kubectl.exit_on_fail[@name]
    end

    def switch_context(&block)
      kubectl = Kubes.config.kubectl
      context = kubectl.context
      if context
        previous_context = sh_capture("kubectl config current-context")
        sh("kubectl config use-context #{context}", mute: true)
        result = block.call
        if !previous_context.blank? && !kubectl.context_keep
          sh("kubectl config use-context #{previous_context}", mute: true)
        end
        result
      else
        block.call
      end
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
      klass = Kubes.kustomize? ? Args::Kustomize : Args::Standard
      klass.new(@name, @options)
    end
    memoize :default

    class << self
      include Kubes::Util::Sh
      def run(name, options={})
        new(name, options).run
      end

      def execute(args, options={})
        sh("kubectl #{args}", options)
      end

      def capture(args, options={})
        resp = sh_capture("kubectl #{args}", options)
        if args.include?('-o json')
          JSON.load(resp) # data
        else
          resp
        end
      end
    end
  end
end

