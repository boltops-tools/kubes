module Kubes::Hooks
  class Builder
    extend Memoist
    include Dsl
    include DslEvaluator
    include Kubes::Logging
    include Kubes::Util::Sh

    attr_accessor :name
    def initialize(name, file)
      @name = name.to_s
      @file = file # IE: .kubes/config/kubectl/hooks.rb
      @hooks = {before: {}, after: {}}
    end

    def build
      return @hooks unless File.exist?(@file)
      evaluate_file(@file)
      @hooks.deep_stringify_keys!
    end
    memoize :build

    def run_hooks
      build
      run_hook("before")
      out = yield if block_given?
      run_hook("after")
      out
    end

    def run_hook(type)
      execute = @hooks.dig(type, @name.to_s, "execute")
      return unless execute

      exit_on_fail = @hooks.dig(type, @name.to_s, "exit_on_fail")
      exit_on_fail = exit_on_fail.nil? ? true : exit_on_fail

      logger.info "Running #{type} hook"
      sh(execute, exit_on_fail: exit_on_fail)
    end
  end
end
