# DSL Example

Here are some examples with the DSL:

.kubes/resources/demo-web/deployment.rb

```ruby
name "demo-web"
labels(app: name, extra: extra)
namespace "demo"

replicas 1
image built_image # IE: tongueroo/demo-web:kubes-2020-06-13T19-55-16-43afc6e
```

.kubes/resources/demo-web/service.rb

```ruby
name "demo-web"
labels(app: name, extra: extra)
namespace "demo"
ports [
  port: 80,
  protocol: "TCP",
  targetPort: 8080,
]
type "NodePort"
```

.kubes/resources/demo-web/ingress.rb

```ruby
name "demo-web-ingress"
labels(app: name, extra: extra)
namespace "demo"

serviceName "demo-web"
servicePort 80
```

The `name` helper accounts for `KUBES_EXTRA` and appends the value.