module Kubes
  class CLI < Command
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean

    image_option = Proc.new {
      option :image, desc: "override image"
    }

    desc "docker SUBCOMMAND", "Docker subcommands"
    long_desc Help.text(:docker)
    subcommand "docker", Docker

    desc "apply APP [RESOURCE]", "Apply the Kubenetes YAML files without changing them"
    long_desc Help.text(:apply)
    image_option.call
    def apply(app=nil, resource=nil)
      Apply.new(options.merge(app: app, resource: resource)).run
    end

    desc "clean", "Remove .kubes/output files"
    long_desc Help.text(:clean)
    image_option.call
    def clean
      Clean.new(options).run
    end

    desc "compile", "Compile Kubenetes YAML files from DSL"
    long_desc Help.text(:compile)
    image_option.call
    def compile
      Compile.new(options).run
    end

    desc "delete APP [RESOURCE]", "Delete Kubenetes resources within the app folder"
    long_desc Help.text(:delete)
    image_option.call
    def delete(app=nil, resource=nil)
      Delete.new(options.merge(app: app, resource: resource)).run
    end

    desc "deploy APP [RESOURCE]", "Deploy to Kubenetes: docker build/push, kubes compile, and kubectl apply"
    long_desc Help.text(:deploy)
    image_option.call
    option :build, type: :boolean, default: true, desc: "whether or not to build docker image"
    def deploy(app=nil, resource=nil)
      Deploy.new(options.merge(app: app, resource: resource)).run
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
