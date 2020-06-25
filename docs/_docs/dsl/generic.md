---
title: Generic DSL
---

The generic DSL allows you to create any Kubernetes resource kind with the Kubes DSL. It is useful for resources with no pretty Kubes DSL wrappers yet.  It still has some pretty powerful helper methods.

## Example 1

Here's an example of an example of a make-believe SomeKind resource.

.kubes/resources/web/some_kind.rb

```ruby
name "some-kind"
labels(role: "web")
spec(
  spec1: "v1"
)
field(:data,
  k1: "v1",
  k2: "v2"
)
```

Produces:

.kubes/output/web/some_kind.yaml

```yaml
data:
  k1: v1
  k2: v2
kind: SomeKind
metadata:
  name: some-kind
  labels:
    role: web
spec:
  spec1: v1
```

## DSL Methods

Here's a list of common methods:

Top-level and special fields:

* apiVersion
* kind
* metadata
* resource
* spec
* annotations
* labels
* namespace

{% include dsl/methods.md name="resource" %}
