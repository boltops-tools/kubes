---
title: Helpers
---

Kubes provides some helper methods to help write Kubernetes YAML files.  Here's a list of the helper methods. These are available whether you write your resources in YAML or DSL.

Helper | Description
--- | ---
built_image | Method refers to the latest Docker image built by Kubes. This spares you from having to update the image manually in the deployment resource.
dockerfile_port	| Exposed port extracted from the Dockerfile of the project.
extra | The `KUBES_ENV` value.
with_extra | Appends the `KUBES_ENV` value to a string if it's set. It's covered in the [Extra Env Docs]({% link _docs/extra-env.md %}).

Here's also the source code with the helpers: [helpers.rb](https://github.com/boltops-tools/kubes/blob/master/lib/kubes/compiler/shared/helpers.rb).


## DSL Specific Methods

Each DSL resource has it's own specific methods. Refer to the [DSL Docs]({% link _docs/dsl.md %}) for their methods.