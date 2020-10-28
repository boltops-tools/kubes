module Kubes::Compiler::Shared
  module CustomHelpers
    # Load custom helper methods from project
    @@custom_helpers_loaded = false
    def load_custom_helpers
      return if @@custom_helpers_loaded
      paths = Dir.glob("#{Kubes.root}/.kubes/helpers/**/*.rb")
      paths.sort_by! { |p| p.size } # so namespaces are loaded first
      paths.each do |path|
        filename = path.sub(%r{.*.kubes/helpers/},'').sub('.rb','')
        module_name = filename.camelize
        self.class.send :include, module_name.constantize
      end
      @@custom_helpers_loaded = true
    end
  end
end
