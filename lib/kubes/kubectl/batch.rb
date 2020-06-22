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

    # kubes apply                   # {role: nil, resource: nil}
    # kubes apply clock             # {role: "clock", resource: nil}
    # kubes apply clock deployment  # {role: "clock", resource: "deployment"}
    def search_expr
      role, resource = @options[:role], @options[:resource]
      if role && resource
        "#{Kubes.root}/.kubes/output/#{role}/#{resource}.yaml"
      elsif role
        "#{Kubes.root}/.kubes/output/#{role}/*"
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
