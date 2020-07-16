---
title: BackendConfig
categories: dsl
---

A BackendConfig is [custom resource definitions (CRDs)](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) that allow you to further customize the load balancer.

Here's an example of a BackendConfig.

.kubes/resources/web/backend-config.rb

```ruby
name "backendconfig"
spec(
  timeoutSec: 40,
  connectionDraining: {
    drainingTimeoutSec: 60,
  },
  sessionAffinity: {
    affinityType: "CLIENT_IP",
  }
)
```

Produces:

.kubes/output/web/backend-config.yaml

```yaml
---
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: my-bsc-backendconfig
spec:
  timeoutSec: 40
  connectionDraining:
    drainingTimeoutSec: 60
  sessionAffinity:
    affinityType: CLIENT_IP
```

## DSL Methods

{% include dsl/methods.md name="backend_config" %}
