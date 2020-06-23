class Kubes::Compiler
  module Decorator
    @@md5s = {}
    def store(name, md5)
      @@md5s[name] = md5
    end

    def fetch(name)
      @@md5s[name]
    end

    def md5s
      @@md5s
    end
    extend self
  end
end
