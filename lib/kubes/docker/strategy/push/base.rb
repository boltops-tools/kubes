module Kubes::Docker::Strategy::Push
  class Base
    include Kubes::Docker::Strategy::Utils

    def initialize(options, name)
      @options, @name = options, name
    end
  end
end
