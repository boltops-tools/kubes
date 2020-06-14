class Kubes::CLI
  class Delete < Base
    include Kubes::Util::Sure

    def run
      sure?
      Compile.new(@options).run
      Kubes::Kubectl.run(:delete, @options)
    end
  end
end
