---
title: Role-Based Resources
---

Role-based resources are your main project's resources.  Kubes groups resources together under a "role".

## Example Structure

Here's an example structure to help explain how role-based resources work.

    .kubes
    └── resources
        ├── clock
        │   └── deployment.yaml
        ├── web
        │   ├── deployment.yaml
        │   └── service.yaml
        └── worker
            └── deployment.yaml

## Resource Roles

Here the resource roles are:

1. clock
2. web
3. worker

You can freely add more roles if needed. This structure is flexible enough to account for most use-cases.

## Deploy

You can deploy specific roles like so:

    kubes deploy clock
    kubes deploy web
    kubes deploy worker

Or you can deploy all roles at once:

    kubes deploy
