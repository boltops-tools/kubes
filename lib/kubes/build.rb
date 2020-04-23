module Kubes
  class Build
    def initialize(options)
      @options = options
      @path = @options[:path]
    end

    def run
      each_resource do |resource, basename|
        yaml = resource.run
        write(basename, yaml)
      end
    end

    def write(basename, yaml)
      dest = "#{Kubes.root}/.kubes/output/#{basename}.yaml"
      FileUtils.mkdir_p(File.dirname(dest))
      IO.write(dest, yaml)
      pretty_dest = dest.sub("#{Kubes.root}/",'')
      puts "Generated #{pretty_dest}"
    end

    def each_resource
      expr = "#{Kubes.root}/.kubes/resources/*.rb"
      Dir.glob(expr).each do |path|
        next unless File.file?(path)
        basename = File.basename(path).sub('.rb','')
        klass_name = basename.camelize
        begin
          klass = "Kubes::Dsl::#{klass_name}".constantize
        rescue NameError
          puts "WARN: No generator support for #{path}. Skipping.".color(:yellow) if ENV["KUBES_WARN_DSL"]
          next
        end
        dsl = klass.new(path: path)
        yield(dsl, basename)
      end
    end
  end
end
