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
    => kubectl apply -f .kubes/output/demo-web/deployment.yaml
    deployment.apps/demo-web created
    => kubectl apply -f .kubes/output/demo-web/service.yaml
    service/demo-web created
    $

What did Kubes do?

{% include kubes-steps.md %}

## Check Resources

Let's check for the created resource on the Kubernetes cluster:

    $ kubectl get all
    NAME                            READY   STATUS    RESTARTS   AGE
    pod/demo-web-7fd7b7b6b4-kv46r   1/1     Running   0          33s

    NAME                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE
    service/demo-web     ClusterIP   10.100.160.248   <none>        80/TCP    33s

    NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/demo-web   1/1     1            1           33s

    NAME                                  DESIRED   CURRENT   READY   AGE
    replicaset.apps/demo-web-7fd7b7b6b4   1         1         1       33s
    $

We can see that the deployment and service got created.

Next, we'll make a change.
