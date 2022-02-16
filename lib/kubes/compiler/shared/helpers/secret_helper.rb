# Including ConfigMap here also
module Kubes::Compiler::Shared::Helpers
  module SecretHelper
    def encode64(v)
      Base64.strict_encode64(v.to_s).strip
    end
    alias_method :base64, :encode64

    def decode64(v)
      Base64.strict_decode64(v)
    end
  end
end
