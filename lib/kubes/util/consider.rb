module Kubes::Util
  module Consider
    def consider?(path)
      File.file?(path) &&
      !path.include?('/resources/base') &&
      !path.include?('/base.') &&
      !path.include?('/all.')
    end
  end
end
