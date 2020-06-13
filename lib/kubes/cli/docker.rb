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
    def push(full_repo=nil)
      # full_repo of nil results in defaulting to the last built image by ufo docker build
      pusher = Kubes::Docker::Push.new(full_repo, options)
      pusher.run
    end
  end
end
