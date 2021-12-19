---
title: Kubes vs Kustomize
nav_text: Kustomize
categories: vs
---

{% include videos/learn/vs.md %}

Though both Kubes and Kustomize build YAML files, they are quite different beasts. Kustomize is more like a `kubectl` feature that decorates YAML. Kubes is more like a tool. Kubes also builds YAML, but it also provides additional features.

Kustomize lets you customize your Kubernetes YAML files with additional `kustomization.yaml` files. The kustomization.yaml files contain configs that tell `kubectl` how to decorate existing Kubernetes YAML files in a template-free way.

Kubes lets you create Kubernetes files more directly. It handles layering and merging YAML files via a conventional structure. It also supports additional conveniences like building Docker images, CLI Customizations, Hooks, etc.

{% include vs/article.md %}

## Project Structures

### Kustomize Project Structure

Kustomize doesn't define a strict a project folder structure. You define any project structure you wish and use `kustomization.yaml` files to connect things together. Here's a possible Kustomize example project structure:

    ├── base
    │   ├── deployment.yaml
    │   ├── kustomization.yaml
    │   └── service.yaml
    └── overlays
        ├── dev
        │   ├── deployment.yaml
        │   ├── kustomization.yaml
        │   └── namespace.yaml
        └── prod
            ├── deployment.yaml
            ├── kustomization.yaml
            └── namespace.yaml

The provided structure allows you to use the same code to create different environments with overlays. The `overlays/dev/kustomization.yaml` file stitches the structure together.

overlays/dev/kustomization.yaml:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - ../../base
patchesStrategicMerge:
  - deployment.yaml
namespace: demo-dev
resources:
- ./namespace.yaml
```

{% include vs/kubes/structure.md %}

## Multiple Environments: Overlays vs Layering

Both Kustomize and Kubes allow you to use the same code to create multiple environments. They take different approaches, though.

### Kustomize Overlays

Kustomize achieves multiple environments via `kustomization.yaml` and manually specifying and wiring how the files should merge. To create different dev and prod environments, we use overlays:

    kubectl apply -k overlays/dev
    kubectl apply -k overlays/prod

{% include vs/kubes/layering.md %}

## DRY Differences

## DRY with Kustomize

Both Kubes and Kustomize try to achieve DRY YAML code. It tries to avoid YAML duplication.

Kustomize takes a purist viewpoint. You use `kustomization.yaml` to decorate original YAML.  The original files are untouched and left as-is.  Here are example overlays files.

overlays/dev/kustomization.yaml:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - ../../base
patchesStrategicMerge:
  - deployment.yaml
namespace: demo-dev
resources:
- ./namespace.yaml
```

overlays/prod/kustomization.yaml:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
bases:
  - ../../base
patchesStrategicMerge:
  - deployment.yaml
namespace: demo-prod
resources:
- ./namespace.yaml
```

While duplication is reduced since the original `base/deployment.yaml` is left untouched, there is duplication in the `kustomization.yaml` files.

## DRY with Kubes

With Kubes, DRY has handled by layering and templating support. Let's first take a look at how layering removes duplication.

Let's focus on `deployment.yaml` to explain and understand layering. Here are the files that get layered.

    .kubes/resources/base/all.yaml            # common YAML for all files
    .kubes/resources/base/deployment.yaml     # common YAML for deployment kind
    .kubes/resources/web/deployment.yaml
    .kubes/resources/web/deployment/dev.yaml  # env-specific that overrides YAML

Each file is merged together and produces a resulting YAML file:

    .kubes/output/web/deployment.yaml

Additionally, you can use ERB templating to keep things DRY.  Here's an example:

.kubes/resources/shared/namespace.yaml

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: demo-<%= Kubes.env %>
  labels:
    app: demo
```

Notice the `<%= Kubes.env %>` templating logic. When is `KUBES_ENV=dev`, then `name: demo-dev`. When is `KUBES_ENV=prod`, then `name: demo-prod`.

You can even define your own custom helpers for even more control. See: [Helpers Docs](https://kubes.guru/docs/helpers/custom/)

## Kubes Features

Kubes does a lot more than building YAML files. Here's a list of features:

{% include intro/features.md %}

## Kubes Kustomize Support

All of that being said, Kubes also supports Kustomize.  So if you’re a Kustomize user, you can use it with Kubes. Here's an example Kustomize structure with Kubes.

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

In Kustomize mode, Kubes will call `kubectl apply -k`.  Here's an example:

    kubes deploy overlays/dev

This calls:

    kubectl apply -k .kubes/output/overlays/dev

## Summary

Kustomize and Kubes are quite different. Kustomize is more of a feature to kubectl and takes on a purist view on changing YAML files for deployment. Kubes has similar merging concepts as Kustomize in the form of layering. Kustomize is more about control things with additional `kustomization.yaml` configurations. Whereas, Kubes takes more of a convention-over-configuration approach, so it just works without having to do extra prewiring work.  Kubes additionally helps you build your Docker images.
