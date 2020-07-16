---
title: DaemonSet
categories: dsl
---

## Example

Here's an example of a DaemonSet.

.kubes/resources/shared/daemon_set.rb

```ruby
name "calico-node"
namespace "kube-system"
labels("k8s-app": "calico-node")
updateStrategy(
  type: "RollingUpdate",
  rollingUpdate: {
    maxUnavailable: 1
  }
)
annotations(
  "*scheduler**.alpha.kubernetes.io/critical-pod": '*'
)
```

Produces:

.kubes/output/shared/daemon_set.yaml

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  annotations:
    "*scheduler**.alpha.kubernetes.io/critical-pod": "*"
  name: calico-node
  labels:
    k8s-app: calico-node
  namespace: kube-system
spec:
  updateStrategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
```

## DSL Methods

Here's a list of more common methods:

* minReadySeconds
* revisionHistoryLimit
* selector
* template
* updateStrategy

{% include dsl/methods.md name="daemon_set" %}
