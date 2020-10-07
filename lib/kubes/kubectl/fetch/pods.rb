module Kubes::Kubectl::Fetch
  class Pods < Base
    extend Memoist

    def show
      return unless namespace
      sh("kubectl get pod -n #{namespace}")
    end
  end
end
