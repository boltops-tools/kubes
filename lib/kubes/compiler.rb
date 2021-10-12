module Kubes
  class Compiler
    include Kubes::Hooks::Concern
    include Kubes::Logging
    include Kubes::Util::Consider
    include Kubes::Kubectl::Ordering

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

      write_full

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

      logger.debug "Compiled  #{pretty(dest)}"
    end

    def write_full
      full = sorted_files.inject([]) do |acc, file|
        acc << IO.read(file)
      end
      content = full.join("\n")
      path = "#{Kubes.root}/.kubes/tmp/full.yaml" # write to tmp instead of output so it doesnt interfere with kubes get
      FileUtils.mkdir_p(File.dirname(path))
      IO.write(path, content)
      logger.debug "Compiled  #{pretty(path)}"
    end

    def show_compiled_message?
      !%w[g ge get].include?(ARGV.first)
    end

    def pretty(path)
      path.sub("#{Kubes.root}/",'')
    end
  end
end
