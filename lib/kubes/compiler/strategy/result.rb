class Kubes::Compiler::Strategy
  class Result
    include Kubes::Util::YamlDump

    attr_reader :filename
    def initialize(filename, data)
      @filename, @data = filename, data
    end

    def io?
      @data.respond_to?(:read)
    end

    def compile_decorate!
      @data = Kubes::Compiler::Decorator::Compile.new(@data).result
    end

    def write_decorate!
      @data = Kubes::Compiler::Decorator::Write.new(@data).result
    end

    def content
      yaml_dump(@data)
    end
  end
end
