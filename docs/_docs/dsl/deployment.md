---
title: Deployment DSL
---

DSL builds Kubernetes YAML files with a reasonable default structure.  Each part of the structure can be customized and overridden.

## Basics

.kubes/resources/demo-web/deployment.rb:

```ruby
name "demo-web"
labels(app: name)
namespace "default"
replicas 2
image "nginx"
```

Running the `kubes compile` command:

    $ kubes compile
    Generated .kubes/output/demo-web/deployment.yaml
    $

Produces:

.kubes/output/demo-web/deployment.yaml:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-web
  labels:
    app: demo-web
  namespace: default
spec:
  replicas: 2
  selector:
    matchLabels:
      app: demo-web
  strategy:
    rollingUpdate:
      maxSurge: 25
      maxUnavailable: 25
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: demo-web
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
