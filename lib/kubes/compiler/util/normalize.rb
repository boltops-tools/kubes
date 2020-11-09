module Kubes::Compiler::Util
  module Normalize
    def normalize_kind(path)
      info = path.sub(%r{.*/.kubes/resources/}, '')
      extract_type(info).underscore.camelize # Deployment, Service, Ingress, ManagedCertificate, etc
    end

    # info: web/service.yaml
    def extract_type(info)
      _, kind = info.split('/')
      kind.sub('.yaml','').sub('.yml','').sub('.rb','').sub(/-.*/,'')
    end
  end
end
