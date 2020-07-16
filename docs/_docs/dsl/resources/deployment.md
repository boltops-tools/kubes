---
title: Deployment
categories: dsl
---

DSL builds Kubernetes YAML files with a reasonable default structure.  Each part of the structure can be customized and overridden.

## Basics

.kubes/resources/web/deployment.rb:

```ruby
name "demo-web"
labels(role: "web")
namespace "default"
replicas 2
image "nginx"
```

Produces:

.kubes/output/web/deployment.yaml:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-web
  labels:
    app: demo
  namespace: default
spec:
  replicas: 2
  selector:
    matchLabels:
      app: demo
  strategy:
    rollingUpdate:
      maxSurge: 25
      maxUnavailable: 25
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: demo
    containers:
    - name: demo-web
      image: nginx
```

## More Customizations

You can override any of the attributes within the deployment structure. You have first-class citizen access to the DSL helpers methods like template and strategy methods that set reasonable defaults.

Examples:

```ruby
spec(
  replicas: replicas,
  selector: {matchLabels: labels},
  strategy: strategy,
  template: template,
)
```

If you only have a single container:

```ruby
container(
  name: name,
  image: "nginx",
  ports: [
    containerPort: 80
  ]
)
```

For multiple containers:

```ruby
containers([
  name: name,
  image: "nginx",
  ports: [
    containerPort: 80
  ]
])
```

Refer to the source code [syntax/deployment.rb](https://github.com/boltops-tools/kubes/blob/master/lib/kubes/compiler/dsl/syntax/deployment.rb) for more methods available.

## DSL Methods

Here's a list of more common methods:

Top-level and special fields:

* container
* containers
* matchLabels
* maxSurge
* maxUnavailable
* sidecar
* templateMetadata
* templateSpec

deployment.spec fields:

* minReadySeconds
* progressDeadlineSeconds
* replicas
* revisionHistoryLimit
* selector
* strategy
* template

deployment.spec.template.spec.containers fields:

* args
* command
* env
* envFrom
* image
* imagePullPolicy
* lifecycle
* livenessProbe
* containerName
* ports
* readinessProbe
* volumeDevices
* volumeMounts
* workingDir

deployment.spec.template.spec.containers.ports fields:

* containerPort
* hostIP
* hostPort
* portName: Note this field doesn't match the original field name. It's more qualified.
* protocol

{% include dsl/methods.md name="deployment" %}
