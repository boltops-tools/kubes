module Kubes::Hooks
  class Builder
    extend Memoist
    include Dsl
    include DslEvaluator
    include Kubes::Logging

    attr_accessor :name
    def initialize(dsl_file, options={})
      @dsl_file, @options = dsl_file, options # IE: .kubes/config/hooks/kubectl.rb
      @output_file = options[:file] # IE: .kubes/output/web/service.yaml
      @name = options[:name].to_s
      @hooks = {before: {}, after: {}}
    end

    def build
      return @hooks unless File.exist?(@dsl_file)
      evaluate_file(@dsl_file)
      @hooks.deep_stringify_keys!
    end
    memoize :build

    def run_hooks
      build
      run_each_hook("before")
      out = yield if block_given?
      run_each_hook("after")
      out
    end

    def run_each_hook(type)
      hooks = @hooks.dig(type, @name.to_s) || []
      hooks.each do |hook|
        run_hook(type, hook)
      end
    end

    def run_hook(type, hook)
      return unless run?(hook)

      command = File.basename(@dsl_file).sub('.rb','') # IE: kubes, kubectl, docker
      id = "#{command} #{type} #{@name}"
      on = " on: #{hook["on"]}" if hook["on"]
      label = " label: #{hook["label"]}" if hook["label"]
      logger.info  "Running #{id} hook.#{on}#{label}"
      logger.debug "Hook options: #{hook}"
      Runner.new(hook).run
    end

    def run?(hook)
      return false unless hook["execute"]
      return true  unless hook["on"]
      @output_file.include?(hook["on"])
    end
  end
end
