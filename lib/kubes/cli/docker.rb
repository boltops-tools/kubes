class Kubes::CLI
  class Docker < Kubes::Command
    desc "build", "Build docker image."
    long_desc Help.text("docker:build")
    option :push, type: :boolean, default: false
    def build
      builder = Kubes::Docker::Build.new(options)
      builder.run
      push if options[:push]
    end

    desc "push IMAGE", "Push the docker image."
    long_desc Help.text("docker:push")
    option :push, type: :boolean, default: false
    def push
      pusher = Kubes::Docker::Push.new(options)
      pusher.run
    end
  end
end
