module Kubes::Compiler::Util
  module Normalize
    def normalize_kind(path)
      File.basename(path).sub('.rb','').sub(/-.*/,'').underscore.camelize # Deployment, Service, Ingress, ManagedCertificate, etc
    end
  end
end
