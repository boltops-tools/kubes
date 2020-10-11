require 'digest'

module Kubes::Compiler::Decorator
  class Hashable < Base
    include Kubes::Compiler::Util::YamlDump

    def store
      # even though name is required, will allow logic to get the kubectl apply and kubectl to surface the required name error
      name = @data.dig('metadata','name')
      return @data unless name

      # puts "name #{name}" # TODO: scope Kind so Secret and ConfigMap can have the same name...
      md5 = md5(@data)
      @data['metadata']['name'] = "#{name}-#{md5}"
      Storage.store(@data['kind'], name, md5)
      @data
    end

    def md5(data)
      content = yaml_dump(data)
      Digest::MD5.hexdigest(content)[0..9]
    end
  end
end
