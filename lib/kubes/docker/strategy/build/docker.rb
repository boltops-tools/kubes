module Kubes::Docker::Strategy::Build
  class Docker < Base
    def perform
      params = args.flatten.join(' ')
      command = "docker build #{params}"
      run_hooks("docker.rb", name: "build") do
        sh(command)
      end
    end
  end
end
