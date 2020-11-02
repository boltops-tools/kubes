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
      ext = File.extname(@path).sub('.','').to_sym
      map = {
        rb: Dsl,
        yaml: Erb,
        yml: Erb,
      }
      map[ext]
    end
  end
end
