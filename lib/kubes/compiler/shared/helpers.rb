module Kubes::Compiler::Shared
  module Helpers
    extend Kubes::Compiler::Dsl::Core::AttributeMethods
    attribute_methods :name

    # Override to account for KUBES_EXTRA feature
    def name_writer(value)
      @name = extra ? "#{value}-#{extra}" : value
    end

    def built_image
      return @options[:image] if @options[:image] # override

      path = Kubes.config.docker_image_state_path
      unless File.exist?(path)
        raise "Missing file with docker image built by kubes: #{path}"
      end
      IO.read(path)
    end

    def with_extra(value)
      extra ? "#{value}-#{extra}" : value
    end

    def extra
      ENV['KUBES_EXTRA']
    end
  end
end
