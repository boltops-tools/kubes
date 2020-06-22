module Kubes::Kubectl::Args
  class Kustomize < Base
    def apply_args
      args = ["-k"]
      args << resource_path
      args
    end
    alias_method :delete_args, :apply_args

    def get_args
      args = ["-k"]
      args << resource_path
      args += ["-o #{@options[:output]}"] if @options[:output]
      args
    end
    alias_method :describe_args, :get_args

  private
    def resource_path
      [".kubes/output", @options[:role], resource].compact.join('/')
    end

    def resource
      return unless r = @options[:resource] # intentional assignment
      r.include?(".yaml") ? r : "#{r}.yaml"
    end
  end
end
