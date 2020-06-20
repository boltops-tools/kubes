module Kubes
  class Config
    include Singleton
    include DslEvaluator

    attr_reader :config
    def initialize
      @config = defaults
    end

    def defaults
      config = ActiveSupport::OrderedOptions.new

      config.state = ActiveSupport::OrderedOptions.new
      config.state.docker_image_path = "#{Kubes.root}/.kubes/state/docker_image.txt"

      config.logger = Logger.new($stdout)
      config.logger.level = ENV['KUBES_LOG_LEVEL'] || :info

      # Auto-switching options
      config.kubectl = ActiveSupport::OrderedOptions.new
      config.kubectl.context = nil
      config.kubectl.context_keep = true # after switching context keep it
      config.kubectl.exit_on_fail = nil # whether or not continue if the kubectl command fails

      config.kubectl.exit_on_fail_for_apply  = true # whether or not continue if the kubectl apply command fails
      config.kubectl.exit_on_fail_for_delete = false # whether or not continue if the kubectl delete command fails
      # Note: not using config.kubectl.delete.exit_on_fail because delete a method internal to ActiveSupport::OrderedOptions

      config.repo = nil # expected to be set by .kubes/config.rb

      config
    end

    def configure
      yield(@config)
    end

    def load_configs
      evaluate_file(".kubes/config.rb")
      evaluate_file(".kubes/config/env/#{Kubes.env}.rb")
    end
  end
end
