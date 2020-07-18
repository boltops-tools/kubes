---
title: Update App
---

Let's update the app. In this case, we don't need to update the Docker image, so we'll use the `apply` command, which does not run the Docker build phase.

    kubes apply

Here's what the output looks like.  Note, the namespace is not shown for conciseness.

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
    deployment.apps/demo-web   3/3     3            3           3m34s

    NAME               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
    service/demo-web   ClusterIP   172.16.173.96   <none>        80/TCP    3m35s

Let's also use the `kubectl get` command:

    $ kubectl get all
    NAME                            READY   STATUS    RESTARTS   AGE
    pod/demo-web-6f867f469f-5qhn6   1/1     Running   0          3m37s
    pod/demo-web-6f867f469f-cqmpd   1/1     Running   0          7s
    pod/demo-web-6f867f469f-slnsw   1/1     Running   0          108s

    NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
    service/demo-web     ClusterIP   172.16.173.96   <none>        80/TCP    3m38s

    NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/demo-web   3/3     3            3           3m37s

    NAME                                  DESIRED   CURRENT   READY   AGE
    replicaset.apps/demo-web-6f867f469f   3         3         3       3m37s
    $

We can see that there are now 3 replicas running.

Next, we'll delete the app.
