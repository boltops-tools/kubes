---
title: Kubes DSL
---

Kubes supports a DSL that builds Kubernetes YAML files. The DSL substantially reduces the amount of code you have to write. Each part of the structure can be customized and overridden.

## DSL Methods

In general, the available DSL methods correspond to resource fields available. To find available methods:

1. Look the at the source for each of the [resources](https://github.com/boltops-tools/kubes/tree/master/lib/kubes/compiler/dsl/syntax).
2. Refer to each resource's docs, linked at the bottom of this page.
3. And use the `kubectl explain` command.

Sometimes the methods may not exactly match to avoid field names collisions.  Though this is the exception, not the rule.

## Example

Here's a simple example:

.kubes/resources/web/service.rb

```ruby
name "demo-web"
labels(role: "web")
namespace "demo"

port 80
targetPort 80
```

Results in:

.kubes/output/web/service.yaml

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: demo-web
  labels:
    app: demo
  namespace: demo
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 8080
  selector:
    app: demo
  type: NodePort
```

Notice how `port` and `targetPort` correspond to `spec.ports.port` and `spec.ports.targetPort` in the YAML.

## Reader and Writer Methods

In general:

* The DSL methods behave as reader methods when no arguments are passed to it. IE: `name` returns the value.
* The DSL methods behave as writer methods when arguments are passed to it. IE: `name "demo-web"` sets the value.

## Merge Behavior

Generally, the merge should behave as expected. For example, map or Hash fields are merged together from multiple layers. Strings are simply replaced. See more details at [Layering Merge Behavior]({% link _docs/layering/merge-dsl.md %})
