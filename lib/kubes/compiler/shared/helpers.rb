module Kubes::Compiler::Shared
  module Helpers
    extend Kubes::Compiler::Dsl::Core::FieldMethods
    field_methods :name

    def built_image
      return @options[:image] if @options[:image] # override

      path = Kubes.config.state.docker_image_path
      unless File.exist?(path)
        raise "Missing file with docker image built by kubes: #{path}"
      end
      IO.read(path)
    end

    def with_extra(value)
      [value, extra].compact.join('-')
    end

    def extra
      ENV['KUBES_EXTRA']
    end
  end
end
