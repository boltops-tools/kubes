require "json"

module Kubes::Kubectl::Fetch
  class Base
    extend Memoist
    include Kubes::Logging
    include Kubes::Util::Sh

    def initialize(options={})
      @options = options
    end

    def fetch(kind)
      return [] unless namespace
      data = Kubes::Kubectl.capture("get #{kind} -o json -n #{namespace}")
      data['items'] || [] # Note: When fetching only 1 resource, items is not part of structure
    end

    def namespace
      path = ".kubes/output/shared/namespace.yaml"
      return unless File.exist?(path)
      data = Kubes::Kubectl.capture("get -f #{path} -o json")
      data['metadata']['name']
    end
    memoize :namespace
  end
end
