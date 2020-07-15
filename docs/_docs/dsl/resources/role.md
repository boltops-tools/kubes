---
title: Role
categories: dsl
---

## Example

Here's an example of a Role.

.kubes/resources/shared/role.rb

```ruby
name "demo"
apiGroups([""])
resources(["pods"])
verbs(["get", "watch", "list"])
```

Produces:

.kubes/output/shared/role.yaml

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: demo
rules:
- apiGroups:
  - ''
  resources:
  - pods
  verbs:
  - get
  - watch
  - list
```

## DSL Methods

Here's the source of the role resource.

{% include dsl/methods.md name="role" %}

