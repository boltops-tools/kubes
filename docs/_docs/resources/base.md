---
title: Base
---

The base folder is used for purely layering.

## Structure

Here's an example structure, so we can understand how layering works with the base folder.

    .kubes/resources/
    ├── base
    │   ├── all.rb
    │   └── deployment.rb
    └── web
        ├── deployment.rb
        └── service.rb

## Layering

Kubes process the files in the `base` folder first, then it process your [role-based resources]({% link _docs/resources/role.md %}) like web. So:

    kubes deploy web deployment

Will layer:

1. .kubes/resources/base/all.rb
2. .kubes/resources/base/deployment.rb
3. .kubes/resources/web/deployment.rb

More details on layering can be found in the [Layering Docs]({% link _docs/layering.md %}).

Remember files in the base are used just for layering.
