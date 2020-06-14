class Kubes::CLI
  class Kubectl
    include Kubes::Util::Sh

    def initialize(options={})
      @options = options
    end

    def delete
      kubectl "delete -f #{resource_path}"
    end

    def apply
      kubectl "apply -f #{resource_path}"
    end

    def resource_path
      [".kubes/output", @options[:app], resource].compact.join('/')
    end

    def resource
      return unless r = @options[:resource] # intentional assignment
      r.include?(".yaml") ? r : "#{r}.yaml"
    end

    def kubectl(command)
      sh("kubectl #{command}")
    end
  end
end
