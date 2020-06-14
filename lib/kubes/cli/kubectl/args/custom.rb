module Kubes::CLI::Kubectl::Args
  class Custom
    extend Memoist
    include Dsl
    include DslEvaluator

    attr_accessor :name
    def initialize(name)
      @name = name.to_s
      @file = "#{Kubes.root}/.kubes/config/kubectl/args.rb"
      @commands = {}
    end

    def build
      return @commands unless File.exist?(@file)
      evaluate_file(@file)
      @commands.deep_stringify_keys!
    end
    memoize :build

    def args
      args = dig("args")
      args.compact.flatten
    end

    def dig(prop, default=[])
      @commands.dig(@name, prop) || default
    end
  end
end
