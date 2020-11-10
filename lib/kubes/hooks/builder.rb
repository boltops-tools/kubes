module Kubes::Hooks
  class Builder
    extend Memoist
    include Dsl
    include DslEvaluator
    include Kubes::Logging

    attr_accessor :name
    def initialize(file, options={})
      @file, @options = file, options # IE: .kubes/config/hooks/kubectl.rb
      @dsl_file = "#{Kubes.root}/.kubes/config/hooks/#{@file}"
      @output_file = options[:file] # IE: .kubes/output/web/service.yaml
      @name = options[:name].to_s
      @hooks = {before: {}, after: {}}
    end

    def build
      return @hooks unless File.exist?(@dsl_file)
      evaluate_file(@dsl_file)
      evaluate_plugin_hooks
      @hooks.deep_stringify_keys!
    end
    memoize :build

    def evaluate_plugin_hooks
      Kubes::Plugin.plugins.each do |klass|
        hooks_class = hooks_class(klass)
        next unless hooks_class
        plugin_hooks = hooks_class.new
        path = "#{plugin_hooks.path}/#{@file}"
        evaluate_file(path)
      end
    end

    def hooks_class(klass)
      "#{klass}::Hooks".constantize # IE: KubesGoogle::Hooks
    rescue NameError
    end

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
      logger.info  "Hook: Running #{id} hook.#{on}#{label}"
      Runner.new(hook).run
    end

    def run?(hook)
      return false unless hook["execute"]
      return true  unless hook["on"]
      @output_file && @output_file.include?(hook["on"]) # output file is only passed
    end
  end
end
