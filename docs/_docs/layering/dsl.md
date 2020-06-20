---
title: DSL Layering
---

## Resources

The `.kubes/resources` folder is where you define your app resources. For example:

    .kubes
    └── resources
        └── demo-web
            ├── deployment.rb
            └── service.rb

## Layering

You can create a folder matching the name of the resource and provide environment-specific overrides. Example:

    .kubes
    └── resources
        └── demo-web
            ├── deployment
            │   ├── dev.rb
            │   └── prod.rb
            ├── deployment.rb
            ├── service
            │   ├── dev.rb
            │   └── prod.rb
            └── service.rb

The ruby files in the corresponding folders get merged and layered. This allows you to specify different values on a per `KUBES_ENV` basis.
