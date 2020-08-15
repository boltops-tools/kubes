---
title: Kustomize Support
---

Kubes supports Kustomize. So if you're a kustomization user, you can use it with Kubes.

## Structure

If there are any kustomization.yaml files in your `.kubes/resources` folder, Kubes kustomize mode is automatically enabled. Example structure:

    .kubes/resources
    ├── base
    │   ├── deployment.yaml
    │   ├── kustomization.yaml
    │   └── service.yaml
    └── overlays
        ├── dev
        │   └── kustomization.yaml
        └── prod
            └── kustomization.yaml

## Deploy

In Kustomize mode, Kubes will call `kubectl apply -k`.  Here's an example:

    kubes deploy overlays/dev

Will call:

    kubectl apply -k .kubes/output/overlays/dev

With Kubes kustomize mode, an argument to the kubes commands are generally required. The argument is the folder within the `.kubes/resources` folder.

## Environments

To deploy different kustomize environments using different overlays:

    kubes deploy overlays/prod

This results in:

    kubectl apply -k .kubes/output/overlays/prod

## Get

To check created resources.

    kubes get overlays/dev

## Compile

With kustomize mode, all files in `.kubes/resources` are compiled and written to `.kubes/output`.

Also, no Kubes layering is performed, as kustomization overlays should be used instead.
