---
title: Secret DSL
---

## Example

Here's an example of a Secret.

.kubes/resources/web/secret.rb

```ruby
name "demo-secret"
data(
  username: base64("user"),
  password: base64("pass"),
)
```

Produces:

.kubes/output/web/service.yaml

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: demo-secret
  labels:
    app: demo
  namespace: default
data:
  username: dXNlcg==
  password: cGFzcw==
```

## DSL Methods

Here's a list of more common methods:

* data
* stringData
* type

{% include dsl/methods.md name="secret" %}
