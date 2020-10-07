class Kubes::Compiler::Decorator::Hashable
  module Storage
    @@md5s = {}
    def store(kind, name, md5)
      @@md5s[kind] ||= {}
      @@md5s[kind][name] = md5
    end

    def fetch(kind, name)
      @@md5s[kind] ||= {}
      @@md5s[kind][name]
    end

    def md5s
      @@md5s
    end
    extend self
  end
end
