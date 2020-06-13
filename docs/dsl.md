## Deployment DSL

DSL builds Kubenetes YAML files with a reasonable default structure.  Each part of the structure can be customized and overriden.

Here's an example to build a deployment.yaml

.kubes/resources/demo-web/deployment.rb:

```ruby
@name = "demo-web"
@labels = {app: "demo-web"}
@namespace = "default"
@replicas = 2
@image = "nginx"
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
```

## Service DSL

Here's an example of a service.

.kubes/resources/demo-web/service.rb

```ruby
@name = "demo-web"
@port = 80
@targetPort = 3000
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

## Default Port

The default port is generally 80. The container may not be exposing port 80. In this case, adjust `@targetPort`:

.kubes/resources/demo-web/service.rb

```ruby
# ...
@targetPort = 3000
```

## Further Customizations

Refer to [DSL Customizations](docs/cusomtizations.md)