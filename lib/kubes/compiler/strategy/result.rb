class Kubes::Compiler::Strategy
  class Result
    attr_reader :filename, :yaml
    def initialize(filename, yaml)
      @filename, @yaml = filename, yaml
    end
  end
end
