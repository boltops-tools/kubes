module Kubes::Hooks
  class Runner
    include Kubes::Util::Sh
    include Kubes::Logging

    def initialize(hook)
      @hook = hook
      @execute = @hook["execute"]
    end

    def run
      case @execute
      when String
        sh(@execute, exit_on_fail: @hook["exit_on_fail"])
      when -> (e) { e.respond_to?(:public_instance_methods) && e.public_instance_methods.include?(:call) }
        @execute.new.call
      else
        @execute.call
      end
    end
  end
end
