class Kubes::CLI
  class Build < Base
    def run
      Kubes::Docker::Build.new(@options).run
      Kubes::Docker::Push.new(@options).run
    end
  end
end
