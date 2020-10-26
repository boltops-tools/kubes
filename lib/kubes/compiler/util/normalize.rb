module Kubes::Compiler::Util
  module Normalize
    def normalize_kind(path)
      extract_type(path).underscore.camelize # Deployment, Service, Ingress, ManagedCertificate, etc
    end

    def extract_type(path)
      File.basename(path).sub('.yaml','').sub('.yml','').sub('.rb','').sub(/-.*/,'')
    end
  end
end
