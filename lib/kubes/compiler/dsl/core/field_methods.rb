module Kubes::Compiler::Dsl::Core
  module FieldMethods
    # Defines methods attribute methods. Example:
    #
    #    field_method :spec
    #
    # Results in:
    #
    #    def spec(value=nil)
    #      value.nil? ? spec_reader : spec_writer(value)
    #    end
    #
    #    def spec_reader
    #      default = default_spec if respond_to?(:default_spec)
    #      @spec || default
    #    end
    #
    #    def spec_writer(value)
    #      @spec = value
    #    end
    #
    def field_method(name)
      reader = "#{name}_reader"
      writer = "#{name}_writer"

      define_method(name) do |value=nil|
        value.nil? ? send(reader) : send(writer, value)
      end

      define_method(reader) do
        default_meth = "default_#{name}" # IE: default_spec, default_apiVersion etc
        default = send(default_meth) if respond_to?(default_meth.to_sym)
        instance_variable_get("@#{name}") || default
      end

      define_method(writer) do |value|
        instance_variable_set("@#{name}", value)
      end
    end

    def field_methods(*names)
      names.each do |name|
        field_method(name)
      end
    end
  end
end
