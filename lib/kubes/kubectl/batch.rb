class Kubes::Kubectl
  class Batch
    include Kubes::Hooks::Concern
    include Kubes::Logging
    include Kubes::Util::Consider
    include Ordering

    def initialize(name, options={})
      @name, @options = name.to_s, options
    end

    def run
      # @options[:preview] is really only used for kubectl delete
      logger.info "Will run:" if @options[:preview]
      run_hooks("kubes.rb", name: @name) do
        sorted_files.each do |file|
          if @options[:preview]
            logger.info "    kubectl #{@name} -f #{file}"
          else
            Kubes::Kubectl.run(@name, @options.merge(file: file))
          end
        end
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
        "#{Kubes.root}/.kubes/output/#{role}/*.yaml"
      else
        "#{Kubes.root}/.kubes/output/**/*.yaml"
      end
    end

    def files
      files = []
      Dir.glob(search_expr).each do |path|
        next unless process?(path)
        file = path.sub("#{Kubes.root}/", '')
        files << file
      end
      files
    end

    def process?(path)
      consider?(path) && two_levels_deep?(path)
    end

    def two_levels_deep?(path)
      rel_path = path.sub(%r{.*\.kubes/output/},'')
      rel_path.split('/').size == 2
    end
  end
end
