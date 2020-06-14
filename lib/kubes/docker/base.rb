module Kubes::Docker
  class Base
    extend Memoist
    include Kubes::Logging
    include Kubes::Util::Sh

    def initialize(options={})
      @options = options
      @name = self.class.name.split('::').last.underscore
    end

    def run_hooks(name, &block)
      hooks = Kubes::Hooks::Builder.new(name, "#{Kubes.root}/.kubes/config/docker/hooks.rb")
      hooks.build # build hooks
      hooks.run_hooks(&block)
    end

    def args
      # base at end in case of redirection. IE: command > /path
      custom.args + default.args
    end

    def custom
      custom = Kubes::Args::Custom.new(@name, "#{Kubes.root}/.kubes/config/docker/args.rb")
      custom.build
      custom
    end
    memoize :custom

    def default
      Args::Default.new(@name, image_name, @options)
    end
    memoize :default

    @@image_name = nil
    def reserve_image_name
      @@image_name = generate_name
    end

    # Store this in a file because this name gets reference in other tasks later
    # and we want the image name to stay the same when the commands are run separate
    # in different processes.  So we store the state in a file.
    # Only when a new docker build command gets run will the image name state be updated.
    def store_image_name
      FileUtils.mkdir_p(File.dirname(image_state_path))
      IO.write(image_state_path, @@image_name)
    end

    # output can get entirely wiped so dont use that folder
    def image_state_path
      Kubes.config.docker_image_state_path
    end

    # full_image - Includes the tag. Examples:
    #   123456789.dkr.ecr.us-west-2.amazonaws.com/myapp:kubes-2018-04-20T09-29-08-b7d51df
    #   tongueroo/demo-kubes:kubes-2018-04-20T09-29-08-b7d51df
    def image_name
      return generate_name if @options[:generate]
      return @@image_name if @@image_name
      return "tongueroo/demo-kubes:kubes-12345678" if ENV['TEST']

      unless File.exist?(image_state_path)
        puts "Unable to find #{image_state_path} which contains the last docker image name built with kubes build.  Please run `kubes docker build` first."
        exit 1
      end
      IO.read(image_state_path).strip
    end

    @@timestamp = Time.now.strftime('%Y-%m-%dT%H-%M-%S')
    def generate_name
      # IE: tongueroo/demo:kubes-
      ["#{repo}:kubes-#{@@timestamp}", git_sha].compact.join('-')
    end

    def repo
      Kubes.config.repo
    end

    def git_sha
      return @git_sha if @git_sha
      # always call this and dont use the execute method because of the noop option
      git_installed = system("type git > /dev/null 2>&1")
      return unless git_installed && File.exist?("#{Kubes.root}/.git")
      @git_sha = `cd #{Kubes.root} && git rev-parse --short HEAD`
      @git_sha.strip!
    end
  end
end
