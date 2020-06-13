# YAML

You can write your Kubneretes resources in standard YAML.

    .kubes
    └── resources
        └── demo-web
            ├── deployment.yaml
            └── service.yaml

## Templating

Kubes does one thing to provide extra power. Your YAML files are processed through an ERB templating language.  So you have dynamic control. Here's an example with the use of the `built_image` helper.

.kubes/resources/demo-web/deployment.yaml

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-web
  labels:
    app: demo-web
  namespace: default
spec:
  replicas: 2
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
