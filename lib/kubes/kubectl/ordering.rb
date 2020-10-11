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

      sorted = filter_files(sorted)

      @name == "delete" ? sorted.reverse : sorted
    end

    def filter_files(sorted)
      skip = Kubes.config.skip
      skip += ENV['KUBES_SKIP'].split(' ') if ENV['KUBES_SKIP']
      return sorted if skip.empty?
      sorted.reject do |file|
        skip.detect { |text| file.include?(text) }
      end
    end

    # type: kinds or roles
    # value: Examples: kind: deployment, role: web
    def index_for(type, value)
      order = Kubes.config.kubectl.order.send(type) # kinds or roles
      index = order.index(value.to_s) || 999
      i = index.to_s.rjust(3, "0") # pad with 0
      "#{i}-#{value}" # append name so that terms with same index get order alphabetically
    end
  end
end
