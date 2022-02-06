class Kubes::Kubectl
  module Ordering
    def sorted_files
      sorted = files.sort_by do |file|
        # .kubes/output/web/service.yaml
        words = file.split('/')
        role, kind = words[2], words[3] # web, deployment
        kind = kind.sub('.yaml','').underscore.camelize if kind

        kind_i = index_for(:kinds, kind)
        role_i = index_for(:roles, role)

        "#{role_i}/#{kind_i}"
      end

      sorted = filter_skip(sorted)

      @name == "delete" ? sorted.reverse : sorted
    end

    def filter_skip(sorted)
      sorted.reject do |file|
        config_skip?(file)
      end
    end

    def config_skip?(file)
      skip = Kubes.config.skip
      skip += ENV['KUBES_SKIP'].split(' ') if ENV['KUBES_SKIP']
      !!skip.detect { |pattern| file.include?(pattern) }
    end

    # type: kinds or roles
    # value: Examples: kind: deployment, role: web
    def index_for(type, value)
      order = Kubes.config.kubectl.order.send(type) # kinds or roles
      index = order.index(value.to_s) || 999
      i = index.to_s.rjust(3, "0") # pad with 0
      "#{i}-#{value}" # append name so that terms with same index get order alphabetically
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
      rel_path = path.sub(%r{.*\.kubes/(resources|output)/},'')
      rel_path.split('/').size == 2
    end
  end
end
