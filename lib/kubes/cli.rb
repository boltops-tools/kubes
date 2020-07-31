module Kubes
  class CLI < Command
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean

    image_option = Proc.new {
      option :image, desc: "override image"
    }
    compile_option = Proc.new {
      option :compile, type: :boolean, default: true, desc: "whether or not to compile the .kube/resources"
    }
    name_option = Proc.new {
      option :name, aliases: %w[n], desc: "deployment name to use. IE: demo-web"
    }

    desc "docker SUBCOMMAND", "Docker subcommands"
    long_desc Help.text(:docker)
    subcommand "docker", Docker

    desc "apply [ROLE] [RESOURCE]", "Apply the Kubernetes YAML files without building docker image"
    long_desc Help.text(:apply)
    image_option.call
    compile_option.call
    def apply(role=nil, resource=nil)
      Apply.new(options.merge(role: role, resource: resource)).run
    end

    desc "clean", "Remove .kubes/output files"
    long_desc Help.text(:clean)
    image_option.call
    def clean
      Clean.new(options).run
    end

    desc "compile", "Compile Kubernetes YAML files from DSL"
    long_desc Help.text(:compile)
    image_option.call
    def compile
      Compile.new(options).run
    end

    desc "delete [ROLE] [RESOURCE]", "Delete Kubernetes resources within the app folder"
    long_desc Help.text(:delete)
    image_option.call
    option :yes, aliases: %w[y], type: :boolean, desc: "Skip are you sure prompt"
    def delete(role=nil, resource=nil)
      Delete.new(options.merge(role: role, resource: resource)).run
    end

    desc "deploy [ROLE] [RESOURCE]", "Deploy to Kubernetes: docker build/push, kubes compile, and kubectl apply"
    long_desc Help.text(:deploy)
    image_option.call
    option :build, type: :boolean, default: true, desc: "whether or not to build docker image"
    def deploy(role=nil, resource=nil)
      Deploy.new(options.merge(role: role, resource: resource)).run
    end

    desc "describe [ROLE] [RESOURCE]", "Describe Kubernetes resource using the compiled YAML files"
    long_desc Help.text(:describe)
    image_option.call
    compile_option.call
    def describe(role=nil, resource=nil)
      Describe.new(options.merge(role: role, resource: resource)).run
    end

    desc "exec", "Exec into the latest container from the deployment"
    long_desc Help.text(:exec)
    compile_option.call
    name_option.call
    def exec(*cmd)
      Exec.new(options.merge(cmd: cmd)).run
    end

    desc "get [ROLE] [RESOURCE]", "Get Kubernetes resource using the compiled YAML files"
    long_desc Help.text(:get)
    image_option.call
    compile_option.call
    option :output, aliases: %w[o], desc: "Output format: json|yaml|wide|name"
    option :show_pods, type: :boolean, default: true, desc: "Also show pods from deployments"
    def get(role=nil, resource=nil)
      Get.new(options.merge(role: role, resource: resource)).run
    end

    desc "logs", "logs from all deployment pods"
    long_desc Help.text(:logs)
    compile_option.call
    name_option.call
    option :follow, aliases: %w[f], type: :boolean, default: true, desc: "Follow logs"
    def logs(*cmd)
      Logs.new(options.merge(cmd: cmd)).run
    end

    long_desc Help.text(:init)
    Init.options.each { |args| option(*args) }
    register(Init, "init", "init", "Init project")

    desc "completion *PARAMS", "Prints words for auto-completion."
    long_desc Help.text(:completion)
    def completion(*params)
      Completer.new(CLI, *params).run
    end

    desc "completion_script", "Generates a script that can be eval to setup auto-completion."
    long_desc Help.text(:completion_script)
    def completion_script
      Completer::Script.generate
    end

    desc "version", "prints version"
    def version
      puts VERSION
    end
  end
end
