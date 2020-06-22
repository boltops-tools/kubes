---
title: How Kubes Works
---

Kubes is pretty straightforward. Kubes first builds the Docker image. Then it compiles Kubernetes YAML files. Lastly, it merely calls out to `kubectl`.

In fact, you can use Kubes to build the files first, and then run `kubectl` directly. Example:

    kubes docker build
    kubes docker push
    kubes compile  # compiles the .kubes/resources files to .kubes/output

Now, use `kubectl` directly. This will apply all the files:

    kubectl apply --recursive -f .kubes/output

You can also selectively apply specific files:

    kubectl apply -f .kubes/output/web/deployment.yaml
    kubectl apply -f .kubes/output/web/service.yaml

You can also apply with kubes. This will compile the files automatically also.

    kubes apply

The deploy command, does all 3 steps: builds the docker image, compiles the `.kubes/resources` files, and runs kubectl apply.

    kubes deploy

