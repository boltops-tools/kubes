module Kubes::Kubectl::Args
  class Base
    def initialize(name, options={})
      @name, @options = name.to_s, options
    end

    def args
      meth = "#{@name}_args" # IE: apply_args
      send(meth)
    end
  end
end
