---
title: RoleBinding
categories: dsl
---

## Example

Here's an example of a RoleBinding.

.kubes/resources/shared/role_binding.rb

```ruby
name "demo"

subjects([
  {kind: "User", name: "tung@boltops.com"},
])

roleName "demo"
```

Produces:

.kubes/output/shared/role_binding.yaml

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: demo
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: demo
subjects:
- kind: User
  name: tung@boltops.com
```

## DSL Methods

Here's a list of more common methods:

Top-level methods:

* roleRef
* subjects

roleRef level methods

* apiGroup
* roleKind
* roleName

{% include dsl/methods.md name="role_binding" %}
