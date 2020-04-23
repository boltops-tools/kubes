module Kubes
  class Generator
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
      puts "Generated #{dest}"
    end

    def each_resource
      expr = "#{Kubes.root}/.kubes/resources/*.rb"
      Dir.glob(expr).each do |path|
        next unless File.file?(path)
        basename = File.basename(path).sub('.rb','')
        klass_name = basename.camelize
        klass = "Kubes::Dsl::#{klass_name}".constantize
        dsl = klass.new(path: path)
        yield(dsl, basename)
      end
    end


    # def run
    #   evaluator = Dsl::Evaluator.new(path: @path)
    #   evaluator.run
    #   deployment = Builder::Deployment.new(evaluator.vars)
    #   resource = deployment.build
    #   puts YAML.dump(resource)
    # end
  end
end
