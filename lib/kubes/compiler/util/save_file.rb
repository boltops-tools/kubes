module Kubes::Compiler::Util
  module SaveFile
    def save_file(path)
      filename = path.sub(%r{.*\.kubes/resources/},'') # IE: web/deployment.rb or web/deployment.yaml
      filename.sub('.yml','.yaml').sub('.rb','.yaml')
    end
  end
end
