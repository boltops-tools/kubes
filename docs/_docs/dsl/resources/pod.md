---
title: Pod
categories: dsl
---

## Example

Here's an example of a Pod.

.kubes/resources/shared/pod.rb

```ruby
name "busybox1"
hostname "busybox-1"
subdomain "default-subdomain"
containers([
  image: "busybox:1.28",
  command: ["sleep", "3600"],
  name: "busybox",
])
```

Produces:

.kubes/output/shared/pod.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: busybox1
spec:
  containers:
  - image: busybox:1.28
    command:
    - sleep
    - '3600'
    name: busybox
  hostname: busybox-1
  subdomain: default-subdomain
```

## DSL Methods

Here's a list of more common methods:

* activeDeadlineSeconds
* affinity
* automountServiceAccountToken
* containers
* dnsConfig
* dnsPolicy
* enableServiceLinks
* ephemeralContainers
* hostAliases
* hostIPC
* hostNetwork
* hostPID
* hostname
* imagePullSecrets
* initContainers
* nodeName
* nodeSelector
* overhead
* preemptionPolicy
* priority
* priorityClassName
* readinessGates
* restartPolicy
* runtimeClassName
* schedulerName
* securityContext
* serviceAccount
* serviceAccountName
* shareProcessNamespace
* subdomain
* terminationGracePeriodSeconds
* tolerations
* topologySpreadConstraints
* volumes

{% include dsl/methods.md name="pod" %}
