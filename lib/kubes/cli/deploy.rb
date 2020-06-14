class Kubes::CLI
  class Deploy < Base
    def run
      Build.new(@options).run if build?
      Compile.new(@options).run
      Apply.new(@options).run
    end

    def build?
      return false if @options[:build] == false
      @options[:resource].nil? || @options[:resource] == "deployment"
    end
  end
end
