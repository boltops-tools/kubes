Kubes Layering in it's full form allows you to keep your resource definitions DRY and create different environments with the same code.

## Project Structure

Here's an example structure, so we can understand how layering works.

    .kubes/resources/
    ├── base
    │   ├── all.{{ include.ext }}
    │   └── deployment.{{ include.ext }}
    ├── clock
    │   └── deployment.{{ include.ext }}
    └── web
        ├── all.{{ include.ext }}
        ├── deployment
        │   ├── dev.{{ include.ext }}
        │   └── prod.{{ include.ext }}
        ├── deployment.{{ include.ext }}
        └── service.{{ include.ext }}

## Layering Basics

To explain the layering, here's the general processing order that Kubes takes.

1. **Pre Layers**: The `.kubes/resources/base` folder is treated as a base layer.  It gets processed as pre-layers by Kubes.
2. **Main Layer**: Then Kubes will process your `.kubes/resources/ROLE` definitions.
3. **Post Layers**: Lastly, Kubes processes any post-layers in the `.kubes/resources/ROLE/KIND` folders.

Notes

* Both YAML and DSL forms support layering. They can be mixed together.
* In the Main Layer you can define single or multiple resource definitions.

## Full Layering

Here's a table showing the the full layering.

Type | Folder/Pattern | Example
---|---|---
pre | base/all.{{ include.ext }}        | base/all.{{ include.ext }}
pre | base/all/ENV.{{ include.ext }}    | base/all/dev.{{ include.ext }}
pre | base/KIND.{{ include.ext }}       | base/deployment.{{ include.ext }}
pre | base/KIND/base.{{ include.ext }}  | base/deployment/base.{{ include.ext }}
pre | base/KIND/ENV.{{ include.ext }}   | base/deployment/dev.{{ include.ext }}
pre | ROLE/all.{{ include.ext }}        | web/all.{{ include.ext }}
main | ROLE/KIND.{{ include.ext }}      | web/deployment.{{ include.ext }}
post | ROLE/KIND/base.{{ include.ext }} | web/deployment/base.{{ include.ext }}
post | ROLE/KIND/ENV.{{ include.ext }}  | web/deployment/dev.{{ include.ext }}

## Real-World Uses

1. With Kubes layering you can define common fields in `base/all.{{ include.ext }}`. Examples: namespace, labels, annotations. If you have additional common base-level fields, but are specific to a Kind. Then you can defined them in `base/KIND.{{ include.ext }}`. Example: `base/deployment.{{ include.ext }}`
2. Then you can define the core of your resource definition in the `ROLE/KIND.{{ include.ext }}`. Example: `web/deployment.{{ include.ext }}`
3. Finally, you can provide environment-specific overrides in the `ROLE/KIND/ENV.{{ include.ext }}`. Example: `web/deployment/dev.{{ include.ext }}`.

Here's a concrete example of layering with the deployment resource kind:

    .kubes/resources/base/all.{{ include.ext }}
    .kubes/resources/base/deployment.{{ include.ext }}
    .kubes/resources/web/deployment.{{ include.ext }}
    .kubes/resources/web/deployment/dev.{{ include.ext }}

All of these files get layered and merged together to produce a resulting deployment.{{ include.ext }}

    .kubes/output/web/deployment.{{ include.ext }}
