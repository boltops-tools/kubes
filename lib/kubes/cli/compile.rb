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
      Clean.new(@options.merge(mute: true)).run
      Kubes::Compiler.new(@options).run
      @@compiled = true
    end
  end
end
