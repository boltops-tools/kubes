class Kubes::Kubectl
  module Ordering
    def sorted_files
      sorted = files.sort_by do |file|
        # .kubes/output/web/service.yaml
        words = file.split('/')
        role, kind = words[2], words[3] # web, deployment
        kind = kind.sub('.yaml','').underscore.camelize

        kind_i = index_for(:kinds, kind)
        role_i = index_for(:roles, role)

        "#{role_i}/#{kind_i}"
      end
      @name == "delete" ? sorted.reverse : sorted
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
