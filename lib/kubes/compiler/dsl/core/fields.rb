module Kubes::Compiler::Dsl::Core
  module Fields
    # Defines field methods. Example:
    #
    #    field :spec
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
    #      case type # captured by closure. IE: labels:hash => type = hash
    #      when 'hash'
    #        spec_writer_hash(value)
    #      else
    #        @spec = value
    #      end
    #    end
    #
    #    def spec_writer_hash(value)
    #      mode = value.delete(:_mode)
    #      @spec = {} if mode == "reset"
    #      @spec ||= {}
    #      @spec.deeper_merge!(value)
    #    end
    #
    def field(name)
      name, type = name.to_s.split(':')
      type ||= 'string'

      reader = "#{name}_reader"
      writer = "#{name}_writer"
      ivar = "@#{name}"
      writer_hash = "#{name}_writer_hash"

      define_method(name) do |value=nil|
        value.nil? ? send(reader) : send(writer, value)
      end

      define_method(reader) do
        default_meth = "default_#{name}" # IE: default_spec, default_apiVersion etc
        default = send(default_meth) if respond_to?(default_meth.to_sym)
        instance_variable_get(ivar) || default
      end

      define_method(writer) do |value|
        case type
        when 'hash'
          send(writer_hash, value)
        else # string, object, etc
          instance_variable_set(ivar, value)
        end
      end

      define_method(writer_hash) do |value|
        mode = value.delete(:_mode) # special treatment
        result = instance_variable_get(ivar)
        result = {} if mode == "reset" # allow user to override with mode: reset option
        result ||= {} # maintain value for layering
        result.deeper_merge!(value)
        instance_variable_set(ivar, result)
      end
    end

    def fields(*names)
      names.each do |name|
        field(name)
      end
    end
  end
end
