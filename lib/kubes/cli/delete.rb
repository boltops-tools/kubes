class Kubes::CLI
  class Delete < Base
    include Kubes::Util::Sure

    def run
      sure?("This will delete resources. Are you sure?")
      Compile.new(@options).run
      Kubes::Kubectl.run(:delete, @options)
    end
  end
end
