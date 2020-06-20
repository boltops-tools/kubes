---
title: Ordering
---

Kubes will apply resources in a order so dependent resources are created first.

## Apply

Here's an example that shows it creating the deployment first, then the service, and last the ingress.

    $ kubes apply
    Compiled  .kubes/resources files
    Deploying kubes files
    => kubectl apply -f .kubes/output/demo-web/deployment.yaml
    deployment.apps/demo-web created
    => kubectl apply -f .kubes/output/demo-web/service.yaml
    service/demo-web created
    => kubectl apply -f .kubes/output/demo-web/ingress.yaml
    ingress.networking.k8s.io/demo-web created
    $

## Delete

Kubes will delete in the reverse order.

    $ kubes delete -y
    Compiled  .kubes/resources files
    => kubectl delete -f .kubes/output/demo-web/ingress.yaml
    ingress.networking.k8s.io "demo-web" deleted
    => kubectl delete -f .kubes/output/demo-web/service.yaml
    service "demo-web" deleted
    => kubectl delete -f .kubes/output/demo-web/deployment.yaml
    deployment.apps "demo-web" deleted
    $