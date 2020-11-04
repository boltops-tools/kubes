---
title: How Kubes Works
---

Kubes is pretty straightforward. Kubes first builds the Docker image. Then it compiles Kubernetes YAML files. Lastly, it merely calls out to `kubectl`.

In fact, you can use Kubes to build the files first, and then run `kubectl` directly. Example:

    kubes docker build
    kubes docker push
    kubes compile  # compiles the .kubes/resources files to .kubes/output

Now, use `kubectl` directly and apply them in the proper order:

    kubectl apply -f .kubes/output/shared/namespace.yaml
    kubectl apply -f .kubes/output/web/service.yaml
    kubectl apply -f .kubes/output/web/deployment.yaml

The deploy command simpifily does all 3 steps: build, compile, and apply.

    kubes deploy

You can also run the `kubectl apply` only. The `kube apply` command compiles but will skip the docker build stage if it's already been built.

    kubes apply
