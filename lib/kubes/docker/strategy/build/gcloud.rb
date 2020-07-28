module Kubes::Docker::Strategy::Build
  class Gcloud < Base
    def perform
      command = "gcloud builds submit --tag #{@@image_name}"
      run_hooks "build" do
        sh(command)
      end
    end
  end
end
