---
title: Review Project
---

Let's explore some of the generated files.

    .
    ├── Dockerfile
    ├── .gitignore
    └── .kubes
        ├── config.rb
        └── resources
            ├── base
            │   ├── all.yaml
            │   └── deployment.yaml
            └── web
                ├── deployment
                │   ├── dev.yaml
                │   └── prod.yaml
                ├── deployment.yaml
                └── service.yaml

{% include learn/review.md %}

## Deployment Resource

The `web/deployment.yaml` file is a little more interesting:

.kubes/resources/web/deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-web
  labels:
    role: web
spec:
  replicas: 1
  selector:
    matchLabels:
      role: web
  strategy:
    rollingUpdate:
      maxSurge: 25
      maxUnavailable: 25
    type: RollingUpdate
  template:
    metadata:
      labels:
        role: web
    spec:
      containers:
      - name: demo
        image: <%= built_image %>
```

Notice the `<%= built_image %>`.  Kubes processes the YAML files with ERB templating and replaces these tags.  The `built_image` is a kubes helper method that refers to the latest Docker image built by Kubes. This spares you updating the image manually.

## Base Resource

Also let's check the files in the base folder.

.kubes/resources/base/all.yaml

```yaml
metadata:
  namespace: default
```

.kubes/resources/base/deployment.yaml

```yaml
metadata:
  labels:
    app: demo
spec:
  selector:
    matchLabels:
      app: demo
  template:
    metadata:
      labels:
        app: demo
```

The base folder files are processed first as a part of [Kubes Layering]({% link _docs/layering.md %}). This allows you to define common fields and keep your code DRY.

## Service Resource

Next, let's look at `service.yaml`

.kubes/resources/web/service.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: demo-web
  labels:
    app: demo
  namespace: default
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 8080
  selector:
    app: demo
  type: ClusterIP
```

There's no use of ERB templating here.

Next, we'll deploy the app.
