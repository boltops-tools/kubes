class Kubes::CLI
  class Delete < Base
    include Kubes::Util::Sure

    def run
      compile
      perform(preview: true) unless @options[:yes]
      sure?("This will delete resources. Are you sure?")
      perform(preview: false)
    end

    def perform(preview: false)
      Kubes::Kubectl::Decider.new(:delete, @options.merge(preview: preview)).run
    end
  end
end
