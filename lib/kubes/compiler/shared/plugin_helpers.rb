module Kubes::Compiler::Shared
  module PluginHelpers
    # Load plugin helper methods from project
    @@plugin_helpers_loaded = false
    def load_plugin_helpers
      return if @@plugin_helpers_loaded
      Kubes::Plugin.plugins.each do |klass|
        helpers_class = "#{klass}::Helpers".constantize # IE: KubesAws::Helpers
        self.class.send :include, helpers_class
      end
      @@plugin_helpers_loaded = true
    end
  end
end
