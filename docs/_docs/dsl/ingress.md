---
title: Ingress DSL
---

## Example 1

Here's an example of an ingress.

.kubes/resources/demo-web/ingress.rb

```ruby
name "demo-web-ingress"
namespace "default"

serviceName "demo-web"
servicePort 80
```

Produces:

.kubes/output/demo-web/ingress.yaml

```yaml
---
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: demo-web-ingress
  namespace: demo
spec:
  rules:
  - http:
      paths:
      - path: "/*"
        backend:
          serviceName: demo-web
          servicePort: 80
```

## Example 2

.kubes/resources/demo-web/ingress.rb

```ruby
name "demo-web-ingress"

paths([{
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

Produces:

.kubes/output/demo-web/ingress.yaml

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
