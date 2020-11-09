module Kubes::Compiler::Shared
  module CustomVariables
    include DslEvaluator

    # Load custom variables from project
    @@custom_variables_loaded = false
    def load_custom_variables
      return if Kubes.kustomize?

      ext = File.extname(@path)
      role = @path.sub(%r{.*\.kubes/resources/},'').sub(ext,'').split('/').first # IE: web
      kind = File.basename(@path).sub(ext,'') # IE: deployment
      all = "all"
      if @block_form
        kind = kind.pluralize
        all = all.pluralize
      end

      layers = [
        "base.rb",
        "#{Kubes.env}.rb",
        "base/all.rb",
        "base/all/#{Kubes.env}.rb",
        "base/#{kind}.rb",
        "base/#{kind}/base.rb",
        "base/#{kind}/#{Kubes.env}.rb",
        "#{role}/#{kind}.rb",
        "#{role}/#{kind}/base.rb",
        "#{role}/#{kind}/#{Kubes.env}.rb",
      ]

      layers.each do |layer|
        path = "#{Kubes.root}/.kubes/variables/#{layer}"
        evaluate_file(path)
      end
    end
  end
end
