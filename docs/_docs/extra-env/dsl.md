---
title: DSL Example
---

Kubes provides helper methods to make creating extra environments easy: `with_extra`.  We'll create extra environments under different namespaces.

Here's how you achieve extra environments with the DSL form:

.kubes/resources/web/deployment.rb

```ruby
name "demo-web"
labels(role: "web")
namespace with_extra("default")

replicas 1
image built_image # IE: user/demo-web:kubes-2020-06-13T19-55-16-43afc6e
```

.kubes/resources/web/service.rb

```ruby
name "demo-web"
labels(role: "web")
namespace with_extra("default")
```

The `name` helper accounts for `KUBES_EXTRA` and appends the value.

## Deployment

Then to create an additional environment, it's simple:

    kubectl create ns default-2
    KUBES_EXTRA=2 kubes deploy

To check on the resources:

    kubectl get all -n default-2

## Using Different Name Instead

The example on this page uses the `with_extra` helper to create the deployment and service in another namespace. Another approach is to use the same namespace but different names based on `KUBES_EXTRA`. We also used the `extra` helper here, which is the `KUBES_EXTRA` value. Examples:

.kubes/resources/web/deployment.rb

```ruby
name with_extra("demo-web")
labels(app: name, extra: extra)
namespace "default"

replicas 1
image built_image # IE: user/demo-web:kubes-2020-06-13T19-55-16-43afc6e
```

.kubes/resources/web/service.rb

```ruby
name with_extra("demo-web")
labels(app: name, extra: extra)
namespace "default"
```

Adding label with the `extra` key is optional, but helps with filtering the resources.

    kubectl get all -l extra=2
    kubectl get all -l extra=3

Example:

    $ kubectl get all -l extra=2
    NAME                              READY   STATUS    RESTARTS   AGE
    pod/demo-web-2-5f8b8cbcdc-dmbjj   1/1     Running   0          78s
    pod/demo-web-2-5f8b8cbcdc-kg8hf   1/1     Running   0          78s

    NAME                 TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
    service/demo-web-2   NodePort   172.16.158.166   <none>        80:30148/TCP   78s

    NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/demo-web-2   2/2     2            2           78s

    NAME                                    DESIRED   CURRENT   READY   AGE
    replicaset.apps/demo-web-2-5f8b8cbcdc   2         2         2       79s
    $

The `extra` and `with_extra` helper methods provide flexibility to create these extra environments with either approach.
