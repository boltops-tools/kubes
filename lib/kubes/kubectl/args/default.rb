module Kubes::Kubectl::Args
  class Default
    def initialize(name, options={})
      @name, @options = name.to_s, options
    end

    def args
      if %w[apply delete].include?(@name)
        meth = "#{@name}_args"
        send(meth)
      else
        []
      end
    end

    def apply_args
      args = common_args
      args << resource_path
      args
    end

    def delete_args
      args = common_args
      args << resource_path
      args
    end

  private
    def common_args
      ["-f"]
    end

    def resource_path
      if @options[:file]
        @options[:file]
      else
        [".kubes/output", @options[:app], resource].compact.join('/')
      end
    end

    def resource
      return unless r = @options[:resource] # intentional assignment
      r.include?(".yaml") ? r : "#{r}.yaml"
    end

  end
end
