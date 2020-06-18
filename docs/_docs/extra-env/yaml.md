---
title: YAML Example
---

Kubes provides helper methods to make creating extra environments easy: `with_extra`.  We'll create extra environments under different namespaces.

Here's how you achieve extra environments with the YAML form:

.kubes/resources/demo-web/deployment.rb

```ruby
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-web
  labels:
    app: demo-web
  namespace: <%= with_extra("default") %>
spec:
  replicas: 2
  selector:
    matchLabels:
      app: demo-web
  template:
    metadata:
      labels:
        app: demo-web
    spec:
      containers:
      - image: <%= built_image %>
        name: demo-web
```

.kubes/resources/demo-web/service.rb

```ruby
---
apiVersion: v1
kind: Service
metadata:
  name: demo-web
  labels:
    app: demo-web
  namespace: <%= with_extra("default") %>
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 8080
  selector:
    app: demo-web
  type: NodePort
```

It's important to use the `with_extra` helper to set the namesapce. The helper accounts for `KUBES_EXTRA` and appends the value.

## Deployment

Then to create an additional environment, it's simple:

    kubectl create ns default-2
    KUBES_EXTRA=2 kubes deploy

To check on the resources:

    kubectl get all -n default-2
