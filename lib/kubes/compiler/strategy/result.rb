class Kubes::Compiler::Strategy
  class Result
    attr_reader :filename, :content
    def initialize(filename, content)
      @filename, @content = filename, content
    end

    def io?
      @content.respond_to?(:read)
    end
  end
end
