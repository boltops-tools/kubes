class Kubes::CLI
  class Build < Base
    def run
      return unless build?
      Kubes::Docker.new(@options, "build").run
      Kubes::Docker.new(@options, "push").run
    end

    def build?
      return false if @options[:build] == false || @options[:image] || Kubes.config.image
      @options[:resource].nil? || @options[:resource] == "deployment"
    end
  end
end
