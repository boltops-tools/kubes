class Kubes::CLI
  class Base
    include Kubes::Logging

    def initialize(options={})
      @options = options
    end

    def compile
      Compile.new(@options).run unless @options[:compile] == false
    end
  end
end
