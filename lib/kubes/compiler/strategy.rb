class Kubes::Compiler
  class Strategy
    def initialize(options={})
      @options = options
      @path = options[:path]
    end

    def compile
      klass = strategy_class
      return false unless klass

      strategy = klass.new(@options.merge(path: @path)) # Dsl or Erb
      strategy.run
    end

    def strategy_class
      ext = File.extname(@path)
      case ext
      when '.rb'   then Dsl
      when '.yaml' then Erb
      else Pass
      end
    end
  end
end
