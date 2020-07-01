module Kubes::Compiler::Decorator
  class Base
    def initialize(data)
      @data = data
    end

    def result
      if @data.is_a?(Kubes::Compiler::Dsl::Core::Blocks)
        @data.results.each { |k,v| process(v) } # returns nil
      else
        process(@data) # returns Hash
      end
      @data # important to return @data so we keep the original @data structure: Blocks or Hash
    end
  end
end
