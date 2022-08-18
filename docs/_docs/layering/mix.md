---
title: Mixed Layering
nav_text: Mix and Match
category: layering
order: 3
---

You can mix and match the YAML and DSL forms together and layering still works.

## Project Structure

Here's an example structure, so we can understand how layering works.

    .kubes/resources/
    ├── base
    │   ├── all.yaml
    │   └── deployment.yaml
    └── web
        ├── deployment
        │   ├── dev.yaml
        │   └── prod.yaml
        ├── deployment.rb
        └── service.yaml

Notice, how deployment.rb is defined as a DSL. The layers will still be merged like so:

    .kubes/resources/base/all.yaml
    .kubes/resources/base/deployment.yaml
    .kubes/resources/web/deployment.rb
    .kubes/resources/web/deployment/dev.rb

## Resources Files

.kubes/resources/base/all.yaml

```yaml
metadata:
  namespace: demo-<%= Kubes.env %>
  labels:
    app: demo
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

.kubes/resources/web/deployment.rb

```ruby
name "web"
labels(role: "web")
image "nginx"
```

.kubes/resources/web/deployment/dev.yaml

```yaml
spec:
  replicas: 2
```

## Output

The result is the merged layered files.

```yaml
metadata:
  namespace: demo-dev
  labels:
    app: demo
    role: web
  name: web
spec:
  selector:
    matchLabels:
      app: demo
      role: web
  template:
    metadata:
      labels:
        app: demo
        role: web
    spec:
      containers:
      - image: nginx
        name: web
  replicas: 2
apiVersion: apps/v1
kind: Deployment
```
