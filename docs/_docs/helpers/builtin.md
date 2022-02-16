---
title: Core Built-In Helpers
---

Kubes provides some helper methods to help write Kubernetes YAML files.  Here's a list of the helper methods. These are available whether you write your resources in YAML or DSL.

Helper | Description
--- | ---
decode64 | Base64 decode a string.
docker_image | Method refers to the latest Docker image built by Kubes. This spares you from having to update the image manually in the deployment resource. Note, this can be overridden with the `--image` cli option or the `Kubes.config.image` setting. See: [Docker Image]({% link _docs/intro/docker-image.md %})
dockerfile_port	| Exposed port extracted from the Dockerfile of the project.
encode64 | Base64 encode a string. Also available as `base64` method.
extra | The `KUBES_EXTRA` value.
with_extra | Appends the `KUBES_EXTRA` value to a string if it's set. It's covered in the [Extra Env Docs]({% link _docs/extra-env.md %}).

Here's also the source code with most of the helpers: [helpers.rb](https://github.com/boltops-tools/kubes/blob/master/lib/kubes/compiler/shared/helpers.rb).
