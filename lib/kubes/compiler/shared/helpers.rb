require "base64"
require "json"

module Kubes::Compiler::Shared
  module Helpers
    extend Kubes::Compiler::Dsl::Core::Fields
    fields "name"

    def docker_image
      return @options[:image] if @options[:image] # override
      return Kubes.config.image if Kubes.config.image
      built_image_helper
    end

    def built_image
      Deprecated.new.built_image
      built_image_helper
    end

    def built_image_helper
      path = Kubes.config.state.path
      unless File.exist?(path)
        raise Kubes::MissingDockerImage.new("Missing file with docker image built by kubes: #{path}. Try first running: kubes docker build")
      end
      data = JSON.load(IO.read(path))
      data['image']
    end

    def with_extra(value)
      [value, extra].compact.join('-')
    end

    def extra
      extra = ENV['KUBES_EXTRA']
      extra&.strip&.empty? ? nil : extra # if blank string then also return nil
    end

    def encode64(v)
      Base64.strict_encode64(v.to_s).strip
    end
    alias_method :base64, :encode64

    def decode64(v)
      Base64.strict_decode64(v)
    end
  end
end
