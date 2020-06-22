---
title: Review Project
---

Let's explore some of the generated files.

    .
    ├── Dockerfile
    └── .kubes
        ├── config.rb
        └── resources
            ├── base
            │   └── all.rb
            └── web
                ├── deployment
                │   ├── dev.rb
                │   └── prod.rb
                ├── deployment.rb
                └── service.rb

## Deployment Resource

The `web/deployment.rb` file is a little more interesting:

.kubes/resources/web/deployment.rb

```ruby
name "demo-web"
labels(role: "web")
namespace "default"

replicas 1
image built_image # IE: user/demo:kubes-2020-06-13T19-55-16-43afc6e
```

The DSL form is more concise than the YAML form.  Also, notice the use of the `built_image` helper. The `built_image` is a kubes helper method that refers to the latest Docker image built. This spares you from updating the image manually.

## Base Resource

Also let's check the files in the base folder.

.kubes/resources/base/all.rb

```ruby
namespace "default"
labels(app: "demo")
```

The base folder files are processed first as a part of [Kubes Layering]({% link _docs/layering.md %}). This allows you to define common fields and keep your code DRY.

Next, let's look at `service.rb`

.kubes/resources/web/service.rb

```ruby
name "demo-web"
labels(role: "web")

# Optional since default port is 80
# port 80
# targetPort 80
```

Service is also pretty simple.  Though the DSL may seem simple, it allows you to fully control the generated YAML. You can learn more about the DSL form at: [Deployment DSL Docs]({% link _docs/dsl/deployment.md %})

Next, we'll deploy the app.
