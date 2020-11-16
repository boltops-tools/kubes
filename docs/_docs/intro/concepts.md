---
title: Kubes Concepts
---

## Resources Files

The `.kubes/resources` where you organized Kubernetes resources. Different subfolders within the resources folder represent your app. Example:

    .kubes/resources
    ├── clock
    │   └── deployment.yaml
    ├── worker
    │   └── deployment.yaml
    └── web
        ├── deployment.yaml
        └── service.yaml

Each folder contains your Kubernetes deployment definition, either in [YAML]({% link _docs/yaml.md %}) or [DSL]({% link _docs/dsl.md %}) form. Both can be used together.

## Conventions Over Configuration

Kubes uses Conventions Over Configuration structure to remove boilerplate setup and mental overhead.

You can deploy just the demo-web app

    kubes deploy web

Or you can deploy all 3 with:

    kubes deploy

The deploy command automatically builds the Docker image and replaces the image in the YAML file with the latest built image.

## Layering

Kubes supports layering files together so you can use the same Kubernetes files to build multiple environments like dev and prod. More details in the [Layering Docs]({% link _docs/layering.md %}).
