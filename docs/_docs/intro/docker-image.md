---
title: Docker Image
---

With Kubes, you can use the `docker_image` helper method to select which image to use. It can use images from these sources:

1. CLI Option: The `--image` option specified with the CLI command
2. Kubes Config: Specified by `config.image` in the `.kubes/config.rb`
3. Built Docker Image: The image built from Dockerfile

The CLI option has the highest precedence, and the Built Docker image has the lowest precedence.

## 1. CLI Option

Kubes uses the image from the `--image` option if specified. It's a quick way to override the Docker  image used by Kubes.  Example:

    kubes deploy --image repo/image:tag

When the `--image` option is set, Kubes skips the Docker build phase.

## 2. Kubes Config

If you set the `config.image` in the Kubes config, Kubes will use this prebuilt Docker image instead. Example:

.kubes/config.rb:

```ruby
Kubes.configure do |config|
  config.image = "nginx"
end
```

When `config.image` is set, Kubes skips the Docker build phase.

## 3. Built Docker Image

Kubes can use a Docker image built from your Dockerfile. This is the default behavior of Kubes, as long as the CLI Option and the Kubes Config option is not set.

## Template Example

Here's an example usage of the `docker_image` helper.

.kubes/resources/web/deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
  labels:
    role: web
spec:
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
```

When running `kubes deploy`, Kubes will replace `<%= docker_image %>` with the Docker image from one of the sources described above.
