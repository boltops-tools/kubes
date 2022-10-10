class Kubes::CLI
  class Docker < Kubes::Command
    desc "build", "Build docker image."
    long_desc Help.text("docker:build")
    option :push, type: :boolean, default: false
    def build
      builder = Kubes::Docker.new(options, "build")
      builder.run
      push if options[:push]
    end

    desc "name", "Print the full docker image with tag that was last generated."
    long_desc Help.text("docker:name")
    option :name, type: :boolean, default: false
    def name
      builder = Kubes::Docker.new(options, "build")
      name = builder.read_image_name
      if name
        puts name
      else
        $stderr.puts(<<~EOL)
          WARN: docker image has not yet been built. Please first run:

              kubes docker build

        EOL
      end
    end

    desc "push", "Push the docker image."
    long_desc Help.text("docker:push")
    option :push, type: :boolean, default: false
    def push
      pusher = Kubes::Docker.new(options, "push")
      pusher.run
    end
  end
end
