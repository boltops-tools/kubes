---
title: Update App
---

Let's update the app. In this case, we don't need to update the Docker image so we can use the `apply` command, which does not run the Docker build phase.

    kubes apply

Here's out the output looks like:

    $ kubes apply
    Compiled  .kubes/resources files
    => kubectl apply --recursive -f .kubes/output
    deployment.apps/demo-web configured
    service/demo-web unchanged
    $

The change has been deployed. Let's double check it:

    $ kubectl get all
    NAME                            READY   STATUS    RESTARTS   AGE
    pod/demo-web-58d9585f6c-7g2dh   1/1     Running   0          84s
    pod/demo-web-58d9585f6c-8glcm   1/1     Running   0          36s
    pod/demo-web-58d9585f6c-tncnp   1/1     Running   0          84s

    NAME               TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
    service/demo-web   NodePort   172.16.137.193   <none>        80:32126/TCP   83s

    NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/demo-web   3/3     3            3           85s

    NAME                                  DESIRED   CURRENT   READY   AGE
    replicaset.apps/demo-web-58d9585f6c   3         3         3       85s

We can see that there are now 3 replicas running.

Next, we'll delete the app.
