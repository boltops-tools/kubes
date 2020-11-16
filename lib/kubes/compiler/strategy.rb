class Kubes::Compiler
  class Strategy
    def initialize(options={})
      @options = options
      @path = options[:path]
    end

    def compile
      result = Dispatcher.new(@options.merge(path: @path)).dispatch
      result.decorate!(:pre) # compile pre phase decoration
      result
    end
  end
end
