# YAML Example

Here are some examples with the YAML form:

.kubes/resources/demo-web/deployment.rb

```ruby
<% name("demo-web") -%>
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: <%= name %>
  labels:
    app: <%= name %>
    extra: <%= extra %>
  namespace: demo
spec:
  replicas: 2
  selector:
    matchLabels:
      app: <%= name %>
      extra: <%= extra %>
  strategy:
    rollingUpdate:
      maxSurge: 25
      maxUnavailable: 25
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: <%= name %>
        extra: <%= extra %>
    spec:
      containers:
      - image: gcr.io/tung-275700/demo-web:kubes-2020-06-18T05-47-25-c3ab937
        name: <%= name %>
```

.kubes/resources/demo-web/service.rb

```ruby
<% name("demo-web") -%>
---
apiVersion: v1
kind: Service
metadata:
  name: <%= name %>
  labels:
    app: <%= name %>
    extra: <%= extra %>
  namespace: demo
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 8080
  selector:
    app: <%= name %>
    extra: <%= extra %>
  type: NodePort
```

.kubes/resources/demo-web/ingress.rb

```ruby
<% name("demo-web") -%>
---
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: <%= name %>
  labels:
    app: <%= name %>
    extra: <%= extra %>
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

It's important to use the `name` helper to set and get the name. The `name` helper accounts for `KUBES_EXTRA` and appends the value.