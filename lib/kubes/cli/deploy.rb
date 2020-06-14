class Kubes::CLI
  class Deploy < Base
    def run
      Build.new(@options).run if build?
      Apply.new(@options).run # also calls Compile
    end

    def build?
      return false if @options[:build] == false
      @options[:resource].nil? || @options[:resource] == "deployment"
    end
  end
end
