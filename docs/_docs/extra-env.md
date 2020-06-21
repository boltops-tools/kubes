---
title: Extra Environments
---

Kubes adds the concept of extra environments.  Let say, you have a demo-web app with a deployment and service.

    .kubes/resources
    └── web
        ├── deployment.rb
        └── service.rb

You can create additional environments using the same resource files with a few minor changes.

* [DSL Example]({% link _docs/extra-env/dsl.md %})
* [YAML Example]({% link _docs/extra-env/yaml.md %})

## Deploy

Then to create an additional environment, it's simple:

    KUBES_EXTRA=2 kubes deploy
    KUBES_EXTRA=3 kubes deploy
    # etc
