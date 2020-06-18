module Kubes
  class Compiler
    include Kubes::Logging

    def initialize(options={})
      @options = options
    end

    def run
      each_resource do |result|
        write(result.filename, result.yaml)
      end
      puts "Compiled  .kubes/resources files"
    end

    def each_resource
      expr = "#{Kubes.root}/.kubes/resources/**/*.{rb,yaml}"
      Dir.glob(expr).each do |path|
        next unless consider?(path)
        strategy = Strategy.new(@options.merge(path: path))
        result = strategy.compile
        yield(result) if result
      end
    end

    # Only considering files 2 layers deep. So:
    #
    #    Yes = demo-web/deployment.yaml
    #    No = demo-web/deployment/dev.yaml
    #
    def consider?(path)
      rel_path = path.sub(%r{.*\.kubes/resources/},'')
      two_levels_deep = rel_path.split('/').size <= 2
      two_levels_deep && File.file?(path)
    end

    def write(filename, yaml)
      dest = "#{Kubes.root}/.kubes/output/#{filename}"
      FileUtils.mkdir_p(File.dirname(dest))
      IO.write(dest, yaml)
      pretty_dest = dest.sub("#{Kubes.root}/",'')
      logger.debug "Compiled  #{pretty_dest}"
    end
  end
end
