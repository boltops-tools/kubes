module Kubes::Compiler::Shared::Helpers
  module ExtraHelper
    def with_extra(value)
      [value, extra].compact.join('-')
    end

    def extra
      extra = ENV['KUBES_EXTRA']
      extra&.strip&.empty? ? nil : extra # if blank string then also return nil
    end
  end
end
