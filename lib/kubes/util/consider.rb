module Kubes::Util
  module Consider
    def consider?(path)
      File.file?(path) &&
      !path.include?('/resources/base') &&
      !path.include?('/base.yaml') &&
      !path.include?('/base.yml')
    end
  end
end
