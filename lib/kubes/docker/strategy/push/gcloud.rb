module Kubes::Docker::Strategy::Push
  class Gcloud < Base
    def run
      run_hooks("docker.rb", name: "push") do
        # noop, gcloud builds submit already pushes the image
      end
    end
  end
end
