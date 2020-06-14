class Kubes::CLI
  class Compile < Base
    def run
      Clean.new(@options.merge(mute: true)).run
      Kubes::Compiler.new(@options).run
    end
  end
end
