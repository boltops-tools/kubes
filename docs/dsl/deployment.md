# Deployment DSL

DSL builds Kubenetes YAML files with a reasonable default structure.  Each part of the structure can be customized and overriden.

## Example

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

