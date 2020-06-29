module Kubes::Compiler::Dsl::Syntax
  class DaemonSet < Resource
    fields :minReadySeconds,       # <integer>
           :revisionHistoryLimit,  # <integer>
           :selector,              # <Object> -required-
           :template,              # <Object> -required-
           :updateStrategy         # <Object>

    def default_apiVersion
      "apps/v1"
    end

    def default_spec
      {
        minReadySeconds: minReadySeconds,
        revisionHistoryLimit: revisionHistoryLimit,
        selector: selector,
        template: template,
        updateStrategy: updateStrategy,
      }
    end
  end
end
