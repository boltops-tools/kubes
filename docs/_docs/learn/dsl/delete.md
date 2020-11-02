---
title: Delete App
---

Let's now delete the app and clean up:

    kubes delete

You will be prompted to confirm before deletion.

    $ kubes delete
    Compiled  .kubes/resources files to .kubes/output
    Will run:
        kubectl delete -f .kubes/output/web/deployment.yaml
        kubectl delete -f .kubes/output/web/service.yaml
        kubectl delete -f .kubes/output/shared/namespace.yaml
    This will delete resources. Are you sure? (y/N)

Confirm to delete the resources:

    This will delete resources. Are you sure? (y/N) y
    => kubectl delete -f .kubes/output/web/service.yaml
    service "demo-web" deleted
    => kubectl delete -f .kubes/output/web/deployment.yaml
    deployment.apps "demo-web" deleted
    => kubectl delete -f .kubes/output/shared/namespace.yaml
    namespace "demo" deleted
    $

Let's double-check that the resources have been deleted:

    $ kubectl get all
    No resources found.
    $

Tip: If you want to delete without the prompt, you can use the `-y` option:

    kubes delete -y

Next, we'll look at some next steps.
