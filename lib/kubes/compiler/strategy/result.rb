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
      results = [@data].flatten
      results.map! do |r|
        klass.new(r).result
      end
    end

    def content
      data = filter_skip(@data)
      data.each { |item| item.delete('kubes') }
      return if data.empty?
      result = data.size == 1 ? data.first : data
      yaml_dump(result)
    end

    def skip?
      content.nil?
    end

    def filter_skip(data)
      data.reject do |item|
        item.dig('kubes', 'skip')
      end
    end
  end
end
