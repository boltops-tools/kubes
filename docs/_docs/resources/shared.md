---
title: Shared
---

The `shared` folder purpose is to provide a place for Kubernetes resources that are shared between roles.

## Example Structure

Here's an example structure to help explain how shared resources work.

    .kubes/resources
    ├── clock
    │   └── deployment.rb
    ├── shared
    │   └── secret.rb
    └── web
        ├── deployment.rb
        └── service.rb

## Deploy

When you deploy with Kubes, it will run `kubectl apply` on the shared resources first and then your [role-based resources]({% link _docs/resources/role.md %}) like clock and web.  Example:

    $ kubes apply
    Deploying kubes resources
    => kubectl apply -f .kubes/output/shared/secret.yaml
    secret/demo-secret created
    => kubectl apply -f .kubes/output/clock/deployment.yaml
    deployment.apps/demo-clock created
    => kubectl apply -f .kubes/output/web/service.yaml
    service/demo-web created
    => kubectl apply -f .kubes/output/web/deployment.yaml
    deployment.apps/demo-web created
    $

Kubes will order the creation of shared resources first.  You can override the default ordering with an [Order config]({% link _docs/intro/ordering/custom.md %}).
