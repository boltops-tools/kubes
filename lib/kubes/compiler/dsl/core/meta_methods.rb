module Kubes::Compiler::Dsl::Core
  module MetaMethods
    # Defines methods setting methods. Example:
    #
    #    setter_method :spec
    #
    # Results in:
    #
    #     def spec!(value)
    #       @spec = value
    #     end
    #
    def setter_method(name)
      name_with_bang = "#{name}!" unless name.to_s.include?('!')
      name_without_bang = name_with_bang.sub('!','')
      define_method(name_with_bang) do |v|
        instance_variable_set("@#{name_without_bang}", v)
      end
    end

    def setter_methods(*names)
      names.each do |name|
        setter_method(name)
      end
    end
  end
end
