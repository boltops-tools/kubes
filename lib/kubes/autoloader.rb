require "zeitwerk"

module Kubes
  class Autoloader
    class Inflector < Zeitwerk::Inflector
      def camelize(basename, _abspath)
        map = { cli: "CLI", version: "VERSION" }
        map[basename.to_sym] || super
      end
    end

    class << self
      def setup
        loader = Zeitwerk::Loader.new
        loader.inflector = Inflector.new
        loader.push_dir(File.dirname(__dir__)) # lib

        helpers = "#{kubes_root}/.kubes/helpers"
        loader.push_dir(helpers) if File.exist?(helpers) # project helpers

        loader.setup
      end

      # Autoloader runs so early that Kubes.root is not available, so we must declare it here
      def kubes_root
        ENV['KUBES_ROOT'] || '.'
      end
    end
  end
end
