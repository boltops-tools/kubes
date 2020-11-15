module Kubes::Compiler::Dsl::Syntax
  class Endpoint < Resource
    fields :subsets

    # kubectl explain endpoints.subsets
    fields :addresses,         # <[]Object>
           :notReadyAddresses, # <[]Object>
           :ports              # <[]Object>

    def default_kind
      return @kind_from_block if @kind_from_block
      "Endpoints" # always plural
    end

    def default_apiVersion
      "v1"
    end

    def default_top
      top = super
      top.merge(
        subsets: subsets
      )
    end

    def default_subsets
      [{
        addresses: addresses,
        notReadyAddresses: notReadyAddresses,
        ports: ports,
      }]
    end
  end
end
