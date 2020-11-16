module Kubes::Compiler::Util
  module Normalize
    def normalize_kind(path)
      extract_type(path).underscore.camelize # Deployment, Service, Ingress, ManagedCertificate, etc
    end

    # info: web/service.yaml
    def extract_type(info)
      info = info.sub(%r{.*/.kubes/resources/}, '')
      _, kind = info.split('/')
      kind.sub('.yaml','').sub('.yml','').sub('.rb','').sub(/-.*/,'')
    end
  end
end
