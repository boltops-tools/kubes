---
title: Job
categories: dsl
---

## Example 1

Here's an example of an job.

.kubes/resources/migrate/job.rb

```ruby
name "<%= app %>"
image(docker_image)
```

Produces:

.kubes/output/migrate/job.yaml

```yaml
---
apiVersion: batch/v1
kind: Job
metadata:
  name: demo
  labels:
    app: demo
  namespace: demo-dev
spec:
  template:
    metadata:
      labels:
        app: demo
    spec:
      containers:
      - image: 111111111111.dkr.ecr.us-west-2.amazonaws.com/demo:kubes-2020-10-26T20-25-43
        name: demo
```

## DSL Methods

Here's a list of more common methods:

job.spec.template.spec.containers fields:

* args
* command
* env
* envFrom
* image
* imagePullPolicy
* lifecycle
* livenessProbe
* containerName
* ports
* readinessProbe
* volumeDevices
* volumeMounts
* workingDir

{% include dsl/methods.md name="job" %}
