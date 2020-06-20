---
title: Review Project
---

Let's explore some of the generated files.

    ├── Dockerfile
    ├── .gitignore
    └── .kubes
        ├── config.rb
        └── resources
            └── demo-web
                ├── deployment
                │   ├── dev.yaml
                │   └── prod.yaml
                ├── deployment.yaml
                └── service.yaml

{% include learn/review.md %}

## Resources

The `deployment.rb` file is a little more interesting:

.kubes/resources/demo-web/deployment.rb

```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-web
  labels:
    app: demo-web
  namespace: default
spec:
  replicas: 1
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
    spec:
      containers:
      - name: demo-web
        image: <%= built_image %>
```

Notice the `<%= built_image %>`.  Kubes processes the YAML files with ERB templating and replaces these tags.  The `built_image` is a kubes helper method that refers to the latest Docker image built by Kubes. This spares you updating the image manually.

Next, let's look at `service.yaml`

.kubes/resources/demo-web/service.yaml

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: demo-web
  labels:
    app: demo-web
  namespace: default
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 8080
  selector:
    app: demo-web
  type: ClusterIP
```

There's no use of ERB templating here.

Next, we'll deploy the app.
