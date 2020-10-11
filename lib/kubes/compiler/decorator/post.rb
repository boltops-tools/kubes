module Kubes::Compiler::Decorator
  class Post < Base
    def process
      add_hash(@data)
      clean_namespace
      @data
    end

    def clean_namespace
      return unless @data['kind'] == 'Namespace'
      @data['metadata'].delete('namespace')
      @data
    end

    def add_hash(item, options={})
      # hashable set from previous stack call
      if options[:hashable_field] && item.is_a?(Hash)
        field = options[:hashable_field]
        value_without_md5 = item[field.key]
        @reset_hashable_field = true unless value_without_md5
        if field.hashable? && value_without_md5
          md5 = Hashable::Storage.fetch(field.kind, value_without_md5)
          v = [value_without_md5, md5].compact.join('-')
          item[field.key] = v
        end
      end

      options[:hashable_field] ||= hashable_field(item) # set for next stack call
      # Pretty tricky case. Given:
      #
      #     envFrom:
      #     - secretRef:
      #         name: demo-secret
      #     - configMapRef:
      #         name: demo-config-map
      #
      # Need to reset the stored hashable_field in the call stack.
      # Else the field.kind is cached and the md5 look is incorrect
      # The spec/fixtures/decorators/deployment/both/envFrom.yaml fixture covers this.
      if @reset_hashable_field
        options[:hashable_field] = hashable_field(item)
        @reset_hashable_field = false
      end
      case item
      when Array, Hash
        item.each { |i| add_hash(i, options) }
      end
      item
    end

    # Returns the nested key name that will be hashable. Examples:
    #
    #     1. envFrom example
    #     envFrom:
    #     - secretRef:
    #         name: demo-secret
    #
    #     2. valueFrom example
    #     valueFrom:
    #       secretKeyRef:
    #         name: demo-secret
    #         key: password
    #
    #     3. volumes example
    #     volumes:
    #     - secret:
    #         secretName: demo-secret
    #
    # This is useful to capture for the next level of the stack call
    #
    def hashable_field(item)
      return false unless item.is_a?(Hash)
      field = Hashable::Field.new(item)
      field if field.hashable?
    end
  end
end
