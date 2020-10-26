class Kubes::Compiler::Strategy
  class Dsl < Base
    include Kubes::Compiler::Util::Normalize

    def run
      dsl = dsl_class.new(@options) # Deployment, Service, etc
      data = dsl.run
      Result.new(@save_file, data)
    end

    def dsl_class
      if block_form?
        Kubes::Compiler::Dsl::Core::Blocks
      else
        syntax_class
      end
    end

    def syntax_class
      klass_name = normalize_kind(@save_file)
      "Kubes::Compiler::Dsl::Syntax::#{klass_name}".constantize
    rescue NameError
      logger.debug "Using default resource for: #{klass_name}"
      Kubes::Compiler::Dsl::Syntax::Resource # default
    end

    def block_form?
      type = extract_type(@save_file)
      type.pluralize == type
    end
  end
end
