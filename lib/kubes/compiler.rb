module Kubes
  class Compiler
    include Kubes::Logging
    include Kubes::Util::Consider

    def initialize(options={})
      @options = options
    end

    def run
      resources.each do |path|
        strategy = Strategy.new(@options.merge(path: path))
        result = strategy.compile
        write(result) if result
      end
      puts "Compiled  .kubes/resources files" if show_compiled_message?
    end

    def resources
      paths = []
      expr = "#{Kubes.root}/.kubes/resources/**/*"
      Dir.glob(expr).each do |path|
        next unless process?(path)
        paths << path
      end
      paths
    end

    # Only considering files 2 layers deep. So:
    #
    #    Yes = web/deployment.yaml
    #    No = web/deployment/dev.yaml
    #
    def process?(path)
      if Kubes.kustomize?
        File.file?(path)
      else
        process_standard?(path)
      end
    end

    def process_standard?(path)
      rel_path = path.sub(%r{.*\.kubes/resources/},'')
      two_levels_deep = rel_path.split('/').size <= 2
      two_levels_deep && consider?(path)
    end

    def write(result)
      filename, content = result.filename, result.content
      dest = "#{Kubes.root}/.kubes/output/#{filename}"

      if result.io?
        FileUtils.cp(filename, dest_path) # preserves permission
      else
        FileUtils.mkdir_p(File.dirname(dest))
        IO.write(dest, content)
      end

      pretty_dest = dest.sub("#{Kubes.root}/",'')
      logger.debug "Compiled  #{pretty_dest}"
    end

    def show_compiled_message?
      !%w[g ge get].include?(ARGV.first)
    end
  end
end
