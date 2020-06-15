# Service DSL

Here's an example of a service.

.kubes/resources/demo-web/service.rb

```ruby
@name = "demo-web"
@port = 80
@targetPort = 3000
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
