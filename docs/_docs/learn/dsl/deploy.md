---
title: Deploy App
---

Let's deploy

    kubes deploy

You'll see output like this:

    $ kubes deploy
    => docker build -t 111111111111.dkr.ecr.us-west-2.amazonaws.com/demo:kubes-2020-06-19T04-19-13 -f Dockerfile .
    => docker push 111111111111.dkr.ecr.us-west-2.amazonaws.com/demo:kubes-2020-06-19T04-19-13
    Pushed 111111111111.dkr.ecr.us-west-2.amazonaws.com/demo:kubes-2020-06-19T04-19-13 docker image.
    Docker push took 15s.
    Compiled  .kubes/resources files
    => kubectl apply -f .kubes/output/web/service.yaml
    service/demo-web created
    => kubectl apply -f .kubes/output/web/deployment.yaml
    deployment.apps/demo-web created
    $

What did Kubes do?

{% include kubes-steps.md %}

## Check Resources

Let's check for the created resource on the Kubernetes cluster:

    kubes get

Example output:

    $ kubes get
    => kubectl get --recursive -f .kubes/output
    NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/demo-web   1/1     1            1           10s

    NAME               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
    service/demo-web   ClusterIP   172.16.173.96   <none>        80/TCP    11s

Let's also use the `kubectl get` command:

    $ kubectl get all
    NAME                            READY   STATUS    RESTARTS   AGE
    pod/demo-web-6f867f469f-5qhn6   1/1     Running   0          16s

    NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
    service/demo-web     ClusterIP   172.16.173.96   <none>        80/TCP    17s

    NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/demo-web   1/1     1            1           16s

    NAME                                  DESIRED   CURRENT   READY   AGE
    replicaset.apps/demo-web-6f867f469f   1         1         1       16s
    $

We can see that the deployment and service got created.

Next, we'll make a change.
