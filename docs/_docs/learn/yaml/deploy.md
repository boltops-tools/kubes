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
    => kubectl apply -f .kubes/output/shared/namespace.yaml
    namespace/demo created
    => kubectl apply -f .kubes/output/web/service.yaml
    service/demo-web created
    => kubectl apply -f .kubes/output/web/deployment.yaml
    deployment.apps/demo-web created
    $

Note: Showing an AWS ECR repo, but it may be different if you're using another repo like Google GCR.

What did Kubes do?

{% include kubes-steps.md %}

## Check Resources

Let's check for the created resource on the Kubernetes cluster:

    kubes get

Example output:

    $ kubes get
    => kubectl get --recursive -f .kubes/output
    NAME             STATUS   AGE
    namespace/demo   Active   7s

    NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/demo-web   1/1     1            1           7s

    NAME               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
    service/demo-web   ClusterIP   172.16.201.77   <none>        80/TCP    7s
    $

Let's also use the `kubectl get` command:

    $ kubectl get all
    NAME                            READY   STATUS    RESTARTS   AGE
    pod/demo-web-5cb4f9fb77-lgczj   1/1     Running   0          3m48s

    NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
    service/demo-web     ClusterIP   172.16.201.77   <none>        80/TCP    3m49s

    NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/demo-web   1/1     1            1           3m49s

    NAME                                  DESIRED   CURRENT   READY   AGE
    replicaset.apps/demo-web-5cb4f9fb77   1         1         1       3m49s
    $

We can see that the deployment and service got created.

Next, we'll make a change.
