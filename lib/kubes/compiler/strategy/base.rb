class Kubes::Compiler::Strategy
  class Base
    include Kubes::Compiler::Layering

    def initialize(options={})
      @options = options
      @path = options[:path]

      @filename = @path.sub(%r{.*\.kubes/resources/},'') # IE: demo-web/deployment.rb or demo-web/deployment.yaml
      @save_file = @filename.sub('.rb','.yaml')
    end
  end
end
