module Kubes::Compiler::Shared::Helpers
  module SecretHelper
    # Meant to be used by plugins. IE:
    # google_secret_data and aws_secret_data
    def generic_secret_data(plugin_secret_method, name, options={})
      indent = options[:indent] || 2
      base64 = options[:base64].nil? ? true : options[:base64]

      full_data = send(plugin_secret_method, name, base64: false)
      spacing = " " * indent
      lines = full_data.split("\n")
      new_lines = lines.map do |line|
        key, value = line.split('=')
        value = encode64(value) if base64
        "#{spacing}#{key}: #{value}"
      end
      new_lines.join("\n")
    end

    def encode64(v)
      Base64.strict_encode64(v.to_s).strip
    end
    alias_method :base64, :encode64

    def decode64(v)
      Base64.strict_decode64(v)
    end
  end
end
