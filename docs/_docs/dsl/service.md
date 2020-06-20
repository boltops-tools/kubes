---
title: Service DSL
---

## Example

Here's an example of a Service.

.kubes/resources/demo-web/service.rb

```ruby
name "demo-web"
labels(app: name)
namespace "default"

# Optional since these are the defaults
# port 80
# targetPort 80
#
# type "NodePort"
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

## DSL Methods

Here's a list of more common methods:

* nodePort
* port
* portName: Note this field doesn't match the original field name. It's more qualified.
* ports
* protocol
* selector
* targetPort
* type

{% include dsl/methods.md name="service" %}
