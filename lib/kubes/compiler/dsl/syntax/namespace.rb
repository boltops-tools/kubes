module Kubes::Compiler::Dsl::Syntax
  class Namespace < Resource
    # override
    def default_metadata
      {
        annotations: annotations,
        name: name,
        labels: labels,
        # no namespace
      }
    end
  end
end
