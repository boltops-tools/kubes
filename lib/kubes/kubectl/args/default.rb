module Kubes::Kubectl::Args
  class Default
    def initialize(name, options={})
      @name, @options = name.to_s, options
    end

    def args
      if %w[apply delete get describe].include?(@name)
        meth = "#{@name}_args"
        send(meth)
      else
        []
      end
    end

    def apply_args
      args = ["-f"]
      args << resource_path
      args
    end
    alias_method :delete_args, :apply_args

    def get_args
      args = ["--recursive -f"]
      args << resource_path
      args
    end
    alias_method :describe_args, :get_args

  private

    def resource_path
      if @options[:file] # batch: apply and delete
        @options[:file]
      else # get
        [".kubes/output", @options[:app], resource].compact.join('/')
      end
    end

    def resource
      return unless r = @options[:resource] # intentional assignment
      r.include?(".yaml") ? r : "#{r}.yaml"
    end
  end
end
