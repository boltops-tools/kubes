require 'thor'

class Kubes::CLI
  class Sequence < Thor::Group
    include Thor::Actions
    include Kubes::Logging

  private
    def logger
      Kubes.logger
    end

    def set_source(type)
      override_source_paths(File.expand_path("../../templates/#{type}", __dir__))
    end

    def override_source_paths(*paths)
      # https://github.com/erikhuda/thor/blob/34df888d721ecaa8cf0cea97d51dc6c388002742/lib/thor/actions.rb#L128
      instance_variable_set(:@source_paths, nil) # unset instance variable cache
      # Using string with instance_eval because block doesnt have access to path at runtime.
      self.class.instance_eval %{
        def self.source_paths
          #{paths.flatten.inspect}
        end
      }
    end
  end
end
