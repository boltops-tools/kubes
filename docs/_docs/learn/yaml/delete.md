---
title: Delete App
---

Let's now delete the app and clean up:

    kubes delete

You will be prompted to confirm before deletion. Here's out the output looks like:

    $ kubes delete
    This will delete resources. Are you sure? (y/N) y
    Compiled  .kubes/resources files
    => kubectl delete -f .kubes/output/web/service.yaml
    service "demo-web" deleted
    => kubectl delete -f .kubes/output/web/deployment.yaml
    deployment.apps "demo-web" deleted
    $

Let's double-check that the resources have been deleted:

    $ kubectl get all
    No resources found.
    $

Tip: If you want to delete without the prompt, you can use the `-y` option:

    kubes delete -y

Next, we'll look at some next steps.
