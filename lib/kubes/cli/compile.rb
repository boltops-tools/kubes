class Kubes::CLI
  class Compile < Base
    # Separate command like prune can call compile. Apply also calls Prune.
    # Instead of moving Compile out of Prune, will use this class variable.
    # In case we have other cases where compile is called in another area.
    # We only want compiled to be called once so hooks only fire once.
    # Done here so we don't clean and remove the .kubes/output folder.
    @@compiled = false
    def run
      return if @@compiled
      build_docker_image
      Clean.new(@options.merge(mute: true)).run
      Kubes::Compiler.new(@options).run
      @@compiled = true
    end

    # auto build docker image and push image if kubes docker build not yet called
    def build_docker_image
      return if File.exist?(Kubes.config.state.path)
      Build.new(@options).run
    end
  end
end
