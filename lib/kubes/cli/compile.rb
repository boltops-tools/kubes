class Kubes::CLI
  class Compile < Base
    include Kubes::Logging

    def run
      Kubes::Compiler.new(@options).run
    end
  end
end
