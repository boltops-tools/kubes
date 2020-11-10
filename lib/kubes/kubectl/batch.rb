class Kubes::Kubectl
  class Batch
    include Kubes::Hooks::Concern
    include Kubes::Logging
    include Kubes::Util::Consider
    include Kubes::Util::Sh
    include Ordering

    def initialize(name, options={})
      @name, @options = name.to_s, options
    end

    def run
      # @options[:preview] is really only used for kubectl delete
      logger.info "Will run:" if @options[:preview]
      switch_context do
        run_hooks("kubes.rb", name: @name) do
          sorted_files.each do |file|
            if @options[:preview]
              logger.info "    kubectl #{@name} -f #{file}"
            else
              Kubes::Kubectl.run(@name, @options.merge(file: file))
            end
          end
          prune # important to call within run_hooks for case of GKE IP whitelisting
        end
      end
    end

    def prune
      return unless @name == "apply" # only run for apply
      return unless Kubes.config.auto_prune # prune old secrets and config maps
      Kubes::CLI::Prune.new(@options.merge(yes: true, quiet: true)).run
    end

    def switch_context(&block)
      kubectl = Kubes.config.kubectl
      context = kubectl.context

      unless context
        block.call
        return
      end

      previous_context = sh_capture("kubectl config current-context")
      if previous_context == context
        block.call
        return
      end

      logger.debug "Switching kubectl context to: #{context}"
      sh("kubectl config use-context #{context}", mute: true)
      result = block.call
      if !previous_context.blank? && !kubectl.context_keep
        sh("kubectl config use-context #{previous_context}", mute: true)
      end
      result
    end
  end
end
