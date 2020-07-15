module Kubes::Compiler::Dsl::Syntax
  class RoleBinding < Resource
    # kubectl explain rolebinding
    fields :roleRef, # <Object> -required-
           :subjects # <[]Object>

    # kubectl explain rolebinding.roleRef
    fields :apiGroup,  # <string> -required-
           :roleKind,  # <string> -required- originally kind
           :roleName   # <string> -required- originally name

    def apiVersion
      "rbac.authorization.k8s.io/v1"
    end

    # override superclass method - no spec
    def default_top
      {
        apiVersion: apiVersion,
        kind: kind,
        metadata: metadata,
        roleRef: roleRef,
        subjects: subjects,
      }
    end

    def default_roleRef
      {
        apiGroup: apiGroup,
        kind: roleKind,
        name: roleName,
      }
    end

    def default_roleKind
      "Role"
    end

    def default_apiGroup
      "rbac.authorization.k8s.io"
    end
  end
end
