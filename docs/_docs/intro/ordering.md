---
title: Ordering
---

Generally, Kubes will apply resources in order so dependent resources are created first. If needed, you can completely customize the order: [Custom Ordering]({% link _docs/intro/ordering/custom.md %}).

## Apply

Here's an example that shows it creating the service and deployment first, and then the ingress last.

    $ kubes apply
    Compiled  .kubes/resources files
    Deploying kubes files
    => kubectl apply -f .kubes/output/web/service.yaml
    service/demo-web created
    => kubectl apply -f .kubes/output/web/deployment.yaml
    deployment.apps/demo-web created
    => kubectl apply -f .kubes/output/web/ingress.yaml
    ingress.networking.k8s.io/demo-web created
    $

## Delete

Kubes will delete in the reverse order.

    $ kubes delete -y
    Compiled  .kubes/resources files
    => kubectl delete -f .kubes/output/web/ingress.yaml
    ingress.networking.k8s.io "demo-web" deleted
    => kubectl delete -f .kubes/output/web/deployment.yaml
    deployment.apps "demo-web" deleted
    => kubectl delete -f .kubes/output/web/service.yaml
    service "demo-web" deleted
    $

## Shared Resources First

Resources in the `shared` folder will be applied first.  Example:

    .kubes
    └── resources
        ├── clock
        │   └── deployment.yaml
        ├── web
        │   ├── deployment.yaml
        │   └── service.yaml
        └── shared
            ├── config_map.yaml
            └── secret.yaml

Results in:

    $ kubes apply
    => kubectl apply -f .kubes/output/shared/secret.yaml
    secret/demo-secret created
    => kubectl apply -f .kubes/output/clock/deployment.yaml
    deployment.apps/demo-clock created
    => kubectl apply -f .kubes/output/web/service.yaml
    service/demo-web created
    => kubectl apply -f .kubes/output/web/deployment.yaml
    deployment.apps/demo-web created
    $

