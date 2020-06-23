module Kubes::Compiler::Dsl::Core
  module Files
    def files(*list)
      dir = current_dir
      list.each do |file|
        path = "#{dir}/#{file}"
        load_data_from_file(path)
      end
    end

    def load_data_from_file(path)
      parser = Kubes::Compiler::Dsl::Core::Parser.new(path)
      items = parser.parse
      items.transform_values! { |v| base64(v) } if secret_class?
      data(items)
    end

    def secret_class?
      self.class == Kubes::Compiler::Dsl::Syntax::Secret
    end

    def current_dir
      resources_line = caller.find { |l| l.include?('.kubes/resources') }
      path = resources_line.split(':').first
      File.dirname(path) # IE: /full/path/.kubes/resources
    end
  end
end
