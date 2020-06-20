---
title: Review Project
---

Let's explore some of the generated files.

    ├── Dockerfile
    ├── .gitignore
    └── .kubes
        ├── config.rb
        └── resources
            └── demo-web
                ├── deployment
                │   ├── dev.rb
                │   └── prod.rb
                ├── deployment.rb
                └── service.rb

{% include learn/review.md %}

## Resources

The `deployment.rb` file is a little more interesting:

.kubes/resources/demo-web/deployment.rb

```ruby
name "demo-web"
labels(app: name)
namespace "default"

replicas 1
image built_image # IE: user/demo:kubes-2020-06-13T19-55-16-43afc6e
```

The DSL form is much more concise than the YAML form.  Notice also the use of the `built_image` helper. The `built_image` is a kubes helper method that refers to the latest Docker image built by Kubes. This spares you from having to update the image manually.

Though the DSL many seem simple, it allows you to control the generated YAML fully. You can learn more about the DSL form at: [Deployment DSL Docs]({% link _docs/dsl/deployment.md %})

Next let's look at `service.rb`

.kubes/resources/demo-web/service.rb

```ruby
name "demo-web"
namespace "default"
labels(app: name)

# Optional since default port is 80
# port 80
# targetPort 80
```

Service is also pretty simple.  You can learn more about the DSL form at: [Service DSL Docs]({% link _docs/dsl/service.md %})

Next, we'll deploy the app.
