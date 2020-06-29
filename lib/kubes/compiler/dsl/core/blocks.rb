module Kubes::Compiler::Dsl::Core
  class Blocks < Base
    attr_reader :results
    def run
      @results = {} # Hash key is the name of resource, using it so we can keep a map to handle layering
      super # handles layering and evaluation the main DSL file
      self
    end

    def syntax_instance(meth, name)
      lookup = lookup_key(meth, name)
      klass = "Kubes::Compiler::Dsl::Syntax::#{meth.camelize}".constantize
      syntax = self.class.syntax_instances[lookup]
      return syntax if syntax

      syntax = klass.new(@options.merge(name: name))
      syntax.kind_from_block = meth.camelize
      self.class.syntax_instances[lookup] = syntax
    end

    def lookup_key(meth, name)
      [meth, name].join('-')
    end

    class << self
      def discovered_methods
        syntax = File.expand_path("../syntax", __dir__)
        expr = "#{syntax}/*.rb"
        Dir.glob(expr).map do |path|
          File.basename(path).sub('.rb','')
        end
      end

      def block_method(meth)
        meth = meth.to_s
        define_method meth do |name, &block|
          syntax = syntax_instance(meth, name)
          syntax.instance_eval(&block) if block
          lookup = lookup_key(meth, name)
          @results[lookup] = syntax.result
        end
      end

      @@syntax_instances = {}
      def syntax_instances
        @@syntax_instances
      end
    end

    discovered_methods.each do |meth|
      block_method meth
    end
  end
end
