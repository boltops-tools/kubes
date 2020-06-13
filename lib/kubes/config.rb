module Kubes
  class Config
    include DslEvaluator

    def evaluate
      evaluate_file(".kubes/config.rb")
      evaluate_file(".kubes/config/#{Kubes.env}.rb")
    end

    def repo(v=nil)
      if v.nil?
        @repo
      else
        @repo = v
      end
    end

    def docker_image_state_path
      "#{Kubes.root}/.kubes/state/docker_image.txt"
    end
  end
end
