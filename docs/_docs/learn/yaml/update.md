---
title: Update App
---

Let's update the app. In this case, we don't need to update the Docker image, so we'll use the `apply` command, which does not run the Docker build phase.

    kubes apply

Here's what the output looks like:

    $ kubes apply
    Compiled  .kubes/resources files
    => kubectl apply -f .kubes/output/web/service.yaml
    service/demo-web unchanged
    => kubectl apply -f .kubes/output/web/deployment.yaml
    deployment.apps/demo-web configured
    $

The change has been deployed. Let's double check it:

    kubes get

Example output:

    $ kubes get
    => kubectl get --recursive -f .kubes/output
    NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/demo-web   3/3     3            3           6m5s

    NAME               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
    service/demo-web   ClusterIP   172.16.201.77   <none>        80/TCP    6m5s
    $

Let's also use the `kubectl get` command:

    $ kubectl get all
    NAME                            READY   STATUS    RESTARTS   AGE
    pod/demo-web-5cb4f9fb77-6c7vc   1/1     Running   0          3s
    pod/demo-web-5cb4f9fb77-lgczj   1/1     Running   0          5m25s
    pod/demo-web-5cb4f9fb77-ls28f   1/1     Running   0          3s

    NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
    service/demo-web     ClusterIP   172.16.201.77   <none>        80/TCP    5m26s

    NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/demo-web   3/3     3            3           5m26s

    NAME                                  DESIRED   CURRENT   READY   AGE
    replicaset.apps/demo-web-5cb4f9fb77   3         3         3       5m26s
    $

We can see that there are now 3 replicas running.

Next, we'll delete the app.
