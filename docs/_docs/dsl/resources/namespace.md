---
title: Namespace
categories: dsl
---

## Example

Here's an example of a Namespace.

.kubes/resources/shared/namespace.rb

```ruby
name "demo"
labels(app: "demo") # useful with NetworkPolicy
```

Produces:

.kubes/output/shared/namespace.yaml

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: backend
  labels:
    app: backend
```

## DSL Methods

Here's the source of the namespace resource.

{% include dsl/methods.md name="namespace" %}
