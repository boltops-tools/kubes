class Kubes::Compiler::Strategy
  class Result
    include Kubes::Compiler::Util::YamlDump

    attr_reader :filename
    def initialize(filename, data)
      @filename, @data = filename, data
    end

    def io?
      @data.respond_to?(:read)
    end

    # decorate(:pre) or decorate(:post)
    def decorate!(phase)
      klass = "Kubes::Compiler::Decorator::#{phase.to_s.camelize}".constantize
      @data = klass.new(@data).result
    end

    def content
      yaml_dump(@data)
    end
  end
end
