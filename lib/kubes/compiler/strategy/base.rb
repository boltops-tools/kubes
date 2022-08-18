class Kubes::Compiler::Strategy
  class Base
    include Kubes::Compiler::Layering
    include Kubes::Compiler::Util::Normalize
    include Kubes::Compiler::Util::SaveFile
    include Kubes::Logging
    include Kubes::Util::Pretty

    def initialize(options={})
      @options = options
      @path = options[:path]
      @save_file = save_file(@path)
    end
  end
end
