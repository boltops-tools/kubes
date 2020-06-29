---
title: NetworkPolicy DSL
---

## Example

Here's an example of a NetworkPolicy.

.kubes/resources/web/network_policy.rb

```ruby
name "demo-web-allow-tester"
matchLabels(role: "web")
fromMatchLabels(run: "tester")
```

Produces:

.kubes/output/web/network_policy.yaml

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: demo-web-allow-tester
spec:
  podSelector:
    matchLabels:
      role: web
  ingress:
  - from:
    - podSelector:
        matchLabels:
          run: tester
```

## DSL Methods

Here's a list of more common methods:

* matchLabels
* fromMatchLabels

{% include dsl/methods.md name="network_policy" %}
