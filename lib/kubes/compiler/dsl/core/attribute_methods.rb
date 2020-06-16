module Kubes::Compiler::Dsl::Core
  module AttributeMethods
    # Defines methods setting methods. Example:
    #
    #    attribute_method :spec
    #
    # Results in 2 method definitions:
    #
    #     def spec
    #       @spec
    #     end
    #
    #     def spec!(value)
    #       @spec = value
    #     end
    #
    def attribute_method(name)
      name_with_bang = "#{name}!" unless name.to_s.include?('!')
      name_without_bang = name_with_bang.sub('!','')
      define_method(name_without_bang) do
        instance_variable_get("@#{name_without_bang}")
      end
      define_method(name_with_bang) do |v|
        instance_variable_set("@#{name_without_bang}", v)
      end
    end

    def attribute_methods(*names)
      names.each do |name|
        attribute_method(name)
      end
    end
  end
end
