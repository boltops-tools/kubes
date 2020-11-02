module Kubes
  class Compiler
    include Kubes::Hooks::Concern
    include Kubes::Logging
    include Kubes::Util::Consider

    def initialize(options={})
      @options = options
    end

    def run
      Kubes.config # trigger config load. So can set ENV['VAR'] in config/envs/dev.rb etc
      run_hooks("kubes.rb", name: "compile") do
        results = resources.map do |path|
          strategy = Strategy.new(@options.merge(path: path))
          strategy.compile
        end.compact

        results.each do |result|
          write(result)
        end
      end

      logger.info "Compiled  .kubes/resources files to .kubes/output" if show_compiled_message?
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
        consider?(path) && two_levels_deep?(path)
      end
    end

    def two_levels_deep?(path)
      rel_path = path.sub(%r{.*\.kubes/resources/},'')
      rel_path.split('/').size == 2
    end

    def write(result)
      result.decorate!(:post)
      filename, content = result.filename, result.content
      dest = "#{Kubes.root}/.kubes/output/#{filename}"

      if result.io?
        FileUtils.cp(filename, dest) # preserve permissions
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
