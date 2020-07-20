---
title: NetworkPolicy
categories: dsl
---

## Example

Here's an example of a NetworkPolicy.

.kubes/resources/web/network_policy.rb

```ruby
name "web"
labels(app: "backend")
namespace "backend"

matchLabels(app: "backend", role: "web")
fromNamespace(app: "frontend")
fromPod(app: "backend")
```

Produces:

.kubes/output/web/network_policy.yaml

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: web
  labels:
    app: backend
  namespace: backend
spec:
  podSelector:
    matchLabels:
      app: backend
      role: web
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          app: frontend
    - podSelector:
        matchLabels:
          app: backend
```

Note, the behavior of the from is an *or* since the namespaceSelector and podSelector are separate items.

## Example 2

If you need more control over the ingress selectors, you can use the `from` method. Here's an example:

.kubes/resources/web/network_policy.rb

```ruby
name "web"
labels(app: "backend")
namespace "backend"

matchLabels(app: "backend", role: "web")
from([
  { namespaceSelector: { matchLabels: { app: "frontend" } } },
  { namespaceSelector: { matchLabels: { app: "backend" } } }
])
```

Produces:

.kubes/output/web/network_policy.yaml

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: web
  labels:
    app: backend
  namespace: backend
spec:
  podSelector:
    matchLabels:
      app: backend
      role: web
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          app: frontend
    - namespaceSelector:
        matchLabels:
          app: backend
```

This will allow traffic from pods in either the frontend or backend namespaces to the backend pods.

## DSL Methods

Here's a list of more common methods:

* fromNamespace
* fromPod
* fromIpBlock
* toNamespace
* toPod
* toIpBlock
* from
* to

{% include dsl/methods.md name="network_policy" %}
