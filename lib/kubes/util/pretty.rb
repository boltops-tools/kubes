module Kubes::Util
  module Pretty
    def pretty_path(path)
      path.sub("#{Kubes.root}/",'')
    end
  end
end
