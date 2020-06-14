module Kubes::Docker
  class Build < Base
    def run
      reserve_image_name
      build
      store_image_name
    end

    def build
      params = args.flatten.join(' ')
      command = "docker build #{params}"
      run_hooks "build" do
        sh(command)
      end
    end
  end
end
