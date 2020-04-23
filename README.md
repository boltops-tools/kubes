# Kubes

[![Gem Version](https://badge.fury.io/rb/kubes.png)](http://badge.fury.io/rb/kubes)

[![BoltOps Badge](https://img.boltops.com/boltops/badges/boltops-badge.png)](https://www.boltops.com)

DSL builds Kubenetes YAML files with a reasonable default structure.  Each part of the structure can be customized and overriden.

## Usage

    kubes init     # creates starter .kubes structure
    kubes build    # builds Docker image
    kubes generate # generates YAML files from DSL
    kubes apply    # run `kubectl apply` using the YAML files
    kubes deploy   # build, generate, apply in one step

## Deployment DSL

Here's an example to build a deployment.yaml

.kubes/resources/deployment.rb:

```ruby
@name = "demo-web"
@labels = {app: "demo-web"}
@namespace = "default"
@replicas = 2
@image = "nginx"
@container_port = 80
```

Run the `kubes generate` command:

    $ kubes generate
    Generated .kubes/output/deployment.yaml
    $

It produces:

.kubes/output/deployment.yaml:

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
      container_port: 80
```

## Service DSL

Here's an example of a service.

.kubes/resources/service.rb

```ruby
@name = "demo-web"
@port = 80
@target_port = 3000
```

Run the `kubes generate` command:

    $ kubes generate
    Generated .kubes/output/service.yaml
    $

It produces:


.kubes/output/service.yaml

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: demo-web
spec:
- protocol: TCP
  port: 80
  targetPort: 3000
```

## Customizing

Each part of the structure can be customized and overridden if necessary. Here's an example of overriding with `metadata!` and `spec!`

```ruby
@name = "demo-web"
@labels = {app: "demo-web"}
@namespace = "default"

metadata!(
  name: @name,
  labels: @labels.merge(label2: "value2"),
  namespace: @namespace,
)
spec!(
  replicas: 3,
  selector: {matchLabels: @labels},
  strategy: strategy,
  template: template,
)
```


Here's another example of overriding with `containers!`:

```ruby
@name = "demo-web"
@labels = {app: "demo-web"}
@namespace = "default"
containers!([
  name: @name,
  image: "nginx",
  ports: [
    containerPort: 88
  ]
])
```

If you only have one container for the pod, which is common, you can use `container!`:

```ruby
@name = "demo-web"
@labels = {app: "demo-web"}
@namespace = "default"
container!(
  name: @name,
  image: "nginx",
  ports: [
    containerPort: 88
  ]
)
```


## Installation

Install with:

    gem install kubes

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
