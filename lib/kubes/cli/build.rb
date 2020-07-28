class Kubes::CLI
  class Build < Base
    def run
      Kubes::Docker.new(@options, "build").run
      Kubes::Docker.new(@options, "push").run
    end
  end
end
