---
title: YAML Layering
---

## Resources

The `.kubes/resources` folder is where you define your app resources. For example:

    .kubes
    └── resources
        └── demo-web
            ├── deployment.yaml
            └── service.yaml

## Layering

You can create a folder matching the name of the resource and provide environment-specific overrides. Example:

    .kubes
    └── resources
        └── demo-web
            ├── deployment
            │   ├── dev.yaml
            │   └── prod.yaml
            ├── deployment.yaml
            ├── service
            │   ├── dev.yaml
            │   └── prod.yaml
            └── service.yaml

The yaml files in the corresponding folders get merged and layered. This allows you to specify different values on a per `KUBES_ENV` basis.
