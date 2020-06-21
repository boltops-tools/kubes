class Kubes::Compiler::Strategy
  class Base
    include Kubes::Logging

    def initialize(options={})
      @options = options
      @path = options[:path]

      @filename = @path.sub(%r{.*\.kubes/resources/},'') # IE: web/deployment.rb or web/deployment.yaml
      @save_file = @filename.sub('.rb','.yaml')
    end
  end
end
