module Kubes::Docker
  class Base
    include Kubes::Logging
    include Kubes::Util::Sh

    def initialize(options={})
      @options = options
    end
  end
end
