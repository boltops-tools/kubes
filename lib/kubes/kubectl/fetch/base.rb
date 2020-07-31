require "json"

module Kubes::Kubectl::Fetch
  class Base
    include Kubes::Logging
    include Kubes::Util::Sh

    def initialize(options={})
      @options = options
    end

    def fetch_items
      o = {
        capture: true,
        output: "json",
        show_command: false,
      }
      kubectl = Kubes::Kubectl.new(:get, @options.merge(o)) # kubes get -f .kubes/output
      resp = kubectl.run
      data = JSON.load(resp)
      data['items']
    end
  end
end
