---
title: Basic Variables
nav_text: Basic
categories: variables
---

## Basic Layering Example

Here's an example variables directory structure:

    .kubes/variables
    ├── base.rb
    ├── dev.rb
    └── prod.rb

base.rb

```ruby
@endpoint = "base-endpoint" # overriden by ENV specific variable files.
```

dev.rb

```ruby
@endpoint = "dev-endpoint"
```

prod.rb

```ruby
@endpoint = "prod-endpoint"
```

The `@endpoint` value will be overriden by the ENV specific variable files.

## Deployment YAML

Here's an example deployment.yaml

.kubes/resources/web/deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
  labels:
    role: web
spec:
  replicas: 1  # overridden on a env basis
  selector:
    matchLabels:
      role: web
  template:
    metadata:
      labels:
        role: web
    spec:
      containers:
      - name: web
        image: <%= docker_image %>
        env:
        - name: endpoint
          value: <%= @endpoint %>
```

## Deploy

When you deploy you can use `KUBES_ENV` to and the ENV specific variables will be used:

    KUBES_ENV=dev  kubes deploy

Results in:

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
      - name: web
        image: gcr.io/GOOGLE_PROJECT/demo:kubes-2020-11-07T22-29-02
        env:
        - name: endpoint
          value: dev-endpoint
  replicas: 1
apiVersion: apps/v1
kind: Deployment
```

When using `KUBES_ENV=prod` the endpoint will use the `variables/prod.rb` values.

    KUBES_ENV=prod kubes deploy

Results in:

```yaml
metadata:
  namespace: demo-prod
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
      - name: web
        image: gcr.io/GOOGLE_PROJECT/demo:kubes-2020-11-07T22-29-02
        env:
        - name: endpoint
          value: prod-endpoint
  replicas: 1
apiVersion: apps/v1
kind: Deployment
```

{% include variables/generator.md %}