module Kubes::Compiler::Decorator::Resources
  class Base
    attr_reader :data
    def initialize(data)
      @data = data
    end

    def run
      return @data unless Kubes.config.suffix_hash
      perform
    end
  end
end
