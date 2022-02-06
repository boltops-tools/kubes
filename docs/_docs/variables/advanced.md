---
title: Advanced Variables
nav_text: Advanced
categories: variables
order: 2
---

Basic variables layering should provides enough flexibility and is generally recommended. This page  covers more advanced variables layering.

## Advanced Layering Example

Here's a more complex structure to demonstrate advanced layering.

    .kubes/variables
    ├── base
    │   └── deployment.rb
    ├── base.rb
    ├── dev.rb
    ├── prod.rb
    └── web
        ├── deployment
        │   ├── dev.rb
        │   └── prod.rb
        └── deployment.rb

## Concrete Example

Let's look at a concrete web/deployment.yaml.

Here are the files that get layered when `KUBES_ENV=dev`:

    .kubes/variables/base.rb
    .kubes/variables/dev.rb
    .kubes/variables/base/deployment.rb
    .kubes/variables/web/deployment.rb
    .kubes/variables/web/deployment/dev.rb

And when `KUBES_ENV=prod`:

    .kubes/variables/base.rb
    .kubes/variables/prod.rb
    .kubes/variables/base/deployment.rb
    .kubes/variables/web/deployment.rb
    .kubes/variables/web/deployment/prod.rb

With advanced layering you can target a specific role and kind. So variables are only scoped to the resources you want.

## App-Level Overrides

If KUBES_APP is set, then app level layer overrides will also be processed. Example:

    KUBES_APP=app1 kubes deploy

Here's an example with some of the additional files that get layered:

    .kubes/variables/app1.rb
    .kubes/variables/app1/base.rb
    .kubes/variables/app1/dev.rb

This is useful if you're using kubes as part of a central deployer pattern. For the full list of layers refer to the table below:

## Full Layering Table

Here's a table showing the the full layering.

Folder/Pattern    | Example
------------------|----------------------------
base.rb           | base.rb
ENV.rb            | dev.rb
base/all.rb       | base/all.rb
base/all/ENV.rb   | base/all/dev.rb
base/KIND.rb      | base/deployment.rb
base/KIND/base.rb | base/deployment/base.rb
base/KIND/ENV.rb  | base/deployment/dev.rb
ROLE/KIND.rb      | web/deployment.rb
ROLE/KIND/base.rb | web/deployment/base.rb
ROLE/KIND/ENV.rb  | web/deployment/dev.rb

If KUBES_APP is set then these additional layers are also processed:

Folder/Pattern    | Example
------------------|----------------------------
APP.rb           | app1.rb
APP/base.rb           | app1/base.rb
APP/ENV.rb            | app1/dev.rb
APP/base/all.rb       | app1/base/all.rb
APP/base/all/ENV.rb   | app1/base/all/dev.rb
APP/base/KIND.rb      | app1/base/deployment.rb
APP/base/KIND/base.rb | app1/base/deployment/base.rb
APP/base/KIND/ENV.rb  | app1/base/deployment/dev.rb
APP/ROLE/KIND.rb      | app1/web/deployment.rb
APP/ROLE/KIND/base.rb | app1/web/deployment/base.rb
APP/ROLE/KIND/ENV.rb  | app1/web/deployment/dev.rb

{% include variables/generator.md %}