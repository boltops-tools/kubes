class Kubes::Kubectl
  class Batch
    include Kubes::Util::Consider
    include Ordering

    def initialize(name, options={})
      @name, @options = name.to_s, options
    end

    def run
      sorted_files.each do |file|
        Kubes::Kubectl.run(@name, @options.merge(file: file))
      end
    end

    # kubes apply                        # {app: nil, resource: nil}
    # kubes apply demo-clock             # {app: "demo-clock", resource: nil}
    # kubes apply demo-clock deployment  # {app: "demo-clock", resource: "deployment"}
    def search_expr
      app, resource = @options[:app], @options[:resource]
      if app && resource
        "#{Kubes.root}/.kubes/output/#{app}/#{resource}.yaml"
      elsif app
        "#{Kubes.root}/.kubes/output/#{app}/*"
      else
        "#{Kubes.root}/.kubes/output/**/*"
      end
    end

    def files
      files = []
      Dir.glob(search_expr).each do |path|
        next unless consider?(path)
        file = path.sub("#{Kubes.root}/", '')
        files << file
      end
      files
    end
  end
end
