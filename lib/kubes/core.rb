module Kubes
  module Core
    def root
      ENV['KUBES_ROOT'] || Dir.pwd
    end
  end
end