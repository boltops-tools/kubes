module Kubes::Compiler::Decorator
  class Base
    attr_reader :data
    def initialize(data)
      @data = data
    end

    def run
      return @data unless Kubes.config.suffix_hash
      process
    end

    def result
      if @data.key?(Kubes::Compiler::Dsl::Core::Blocks)
        @data.results.each { |k,v| process(v) } # returns nil
      else
        process # processes and returns @data
      end
      @data # important to return @data so we keep the original @data structure: Blocks or Hash
    end
  end
end
