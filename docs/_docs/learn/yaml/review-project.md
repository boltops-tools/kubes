---
title: Review Project
---

Let's review the resources.

## Namespace

We'll create a namespace for the app resources:

.kubes/resources/shared/namespace.yaml

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: demo
  labels:
    app: demo
```

## Deployment

The `web/deployment.yaml` file is a little more interesting:

.kubes/resources/web/deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
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
      - name: web
        image: <%= built_image %>
```

Notice the `<%= built_image %>`.  Kubes processes the YAML files with ERB templating and replaces these tags.  The `built_image` is a kubes helper method that refers to the latest Docker image built by Kubes. This spares you updating the image manually.

## Base Folder

Also let's check the files in the base folder.

.kubes/resources/base/all.yaml

```yaml
metadata:
  namespace: demo
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

The `all.yaml` means all resources will use the demo namespace.  The `deployment.yaml` adds common labels to all deployment resource kinds.

## Service Resource

Next, let's look at `service.yaml`

.kubes/resources/web/service.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web
  labels:
    role: web
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: <%= dockerfile_port %>
  selector:
    role: web
  type: ClusterIP
```

The `dockerfile_port` helper returns the EXPOSE port in the Dockerfile. This spares you updating this manually, you only have to update the Dockerfile.

Next, we'll deploy the app.
