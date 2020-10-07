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
      result = strategy.run
      result.decorate!(:pre) # compile pre phase decoration
      result
    end

    def strategy_class
      ext = File.extname(@path)
      case ext
      when '.rb'   then Dsl
      when '.yaml','.yml' then Erb
      else Pass
      end
    end
  end
end
