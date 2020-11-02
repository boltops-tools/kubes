---
title: Review Project
---

Let's review the resources.

## Namespace

We'll create a namespace for the app resources:

.kubes/resources/shared/namespace.rb

```ruby
name "demo-#{Kubes.env}"
labels(app: "demo")
```

Notice, the `#{Kubes.env}`. Kubes adds the env to the namespace by default. You can change this with the `init --namespace` option.

## Deployment

The `web/deployment.rb` file is a little more interesting:

.kubes/resources/web/deployment.rb

```ruby
name "demo-web"
labels(role: "web")
namespace "default"

replicas 1
image docker_image # IE: user/demo:kubes-2020-06-13T19-55-16-43afc6e
```

The DSL form is more concise than the YAML form.  Also, notice the use of the `docker_image` helper. The `docker_image` is a kubes helper method that refers to the latest Docker image built. This spares you from updating the image manually.

## Base Folder

Also let's check the files in the base folder.

.kubes/resources/base/all.rb

```ruby
namespace "demo-#{Kubes.env}"
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

Service is also pretty simple.  Though the DSL may seem simple, it allows you to fully control the generated YAML. You can learn more about the DSL form at: [Deployment DSL Docs]({% link _docs/dsl/resources/deployment.md %})

Next, we'll deploy the app.
