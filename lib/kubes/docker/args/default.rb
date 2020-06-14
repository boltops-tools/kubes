module Kubes::Docker::Args
  class Default
    def initialize(name, image_name, options={})
      @name, @image_name, @options = name.to_s, image_name, options
      @dockerfile = "Dockerfile"
    end

    def args
      case @name
      when "build"
        build_args
      when "push"
        [@image_name]
      else
        []
      end
    end

    def build_args
      ["-t #{@image_name} -f #{@dockerfile} ."]
    end


  private
    def common_args
      %w[--recursive -f ]
    end

    def resource_path
      [".kubes/output", @options[:app], resource].compact.join('/')
    end

    def resource
      return unless r = @options[:resource] # intentional assignment
      r.include?(".yaml") ? r : "#{r}.yaml"
    end

  end
end
