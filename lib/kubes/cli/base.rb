class Kubes::CLI
  class Base
    include Kubes::Logging

    def initialize(options={})
      @options = options
    end
  end
end
