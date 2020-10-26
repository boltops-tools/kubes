class Kubes::Compiler::Strategy
  class Base
    include Kubes::Logging
    include Kubes::Compiler::Util::SaveFile

    def initialize(options={})
      @options = options
      @path = options[:path]
      @save_file = save_file(@path)
    end
  end
end
