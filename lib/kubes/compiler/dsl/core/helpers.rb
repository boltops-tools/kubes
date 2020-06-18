module Kubes::Compiler::Dsl::Core
  module Helpers
    def built_image
      return @options[:image] if @options[:image] # override

      path = Kubes.config.docker_image_state_path
      unless File.exist?(path)
        raise "Missing file with docker image built by kubes: #{path}"
      end
      IO.read(path)
    end

    def name_with_extra(value)
      extra = ENV['KUBES_EXTRA']
      extra ? "#{value}-#{extra}" : value
    end
    alias_method :with_extra, :name_with_extra
  end
end
