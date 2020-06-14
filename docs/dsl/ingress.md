# Ingress DSL

Here's an example of an ingress.

.kubes/resources/demo-web/ingress.rb

```ruby
@name = "demo-web-ingress"

paths!([{
  path: "/*",
  backend: {
    serviceName: "hello-world",
    servicePort: 60000,
  },
},{
  path: "/kube",
  backend: {
    serviceName: "hello-kubernetes",
    servicePort: 80,
  },
}])
```

Running the `kubes compile` command:

    $ kubes compile
    Generated .kubes/output/ingress.yaml
    $

Produces:

.kubes/output/ingress.yaml

```yaml
---
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: demo-web-ingress
spec:
  rules:
  - http:
      paths:
      - path: "/*"
        backend:
          serviceName: hello-world
          servicePort: 60000
      - path: "/kube"
        backend:
          serviceName: hello-kubernetes
          servicePort: 80
```
