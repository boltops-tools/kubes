require "base64"
require "json"

module Kubes::Compiler::Shared
  module Helpers
    extend Kubes::Compiler::Dsl::Core::Fields
    fields "name"

    include ConfigMapHelper
    include DockerHelper
    include ExtraHelper
    include SecretHelper
  end
end
