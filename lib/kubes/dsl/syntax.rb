module Kubes::Dsl
  module Syntax
    def containers(list=[])
      @vars[:containers] = list
    end
  end
end
