---
title: Service DSL
---

Here's an example of a Service.

.kubes/resources/demo-web/service.rb

```ruby
name "demo-web"
labels(app: name)
namespace "default"
ports [
  port: 80,
  protocol: "TCP",
  targetPort: 8080,
]
type "NodePort"
```

Running the `kubes compile` command:

    $ kubes compile
    Generated .kubes/output/demo-web/service.yaml
    $

Produces:

.kubes/output/demo-web/service.yaml

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: demo-web
  labels:
    app: demo-web
  namespace: demo
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 8080
  selector:
    app: demo-web
  type: NodePort
```
