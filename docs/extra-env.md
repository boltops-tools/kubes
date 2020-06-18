## Extra Env

Kubes adds the concept of extra environments.  Let say, you deploy a demo-web app with a deployment, service, and ingress.

    .kubes/resources
    └── demo-web
        ├── deployment.rb
        ├── ingress.rb
        └── service.rb

With just a slight adjustment to the way you set `@name`, you can create additional environments like this easily.

## Adjustment

Use the `name_with_extra` helper to adjust the name to allow the creation of extra environments. Here are some examples with the DSL:

.kubes/resources/demo-web/deployment.rb

```ruby
@name = name_with_extra("demo-web")
@labels = {app: name, extra: ENV['KUBES_EXTRA']}
@namespace = "demo"

@replicas = 1
@image = built_image # IE: tongueroo/demo-web:kubes-2020-06-13T19-55-16-43afc6e
```

.kubes/resources/demo-web/service.rb

```ruby
@name = name_with_extra("demo-web")
@labels = {app: @name, extra: ENV['KUBES_EXTRA']}
@namespace = "demo"
@ports = [
  port: 80,
  protocol: "TCP",
  targetPort: 8080,
]
@type = "NodePort"
```

.kubes/resources/demo-web/ingress.rb

```ruby
@name = name_with_extra("demo-web-ingress")
@labels = {app: @name, extra: ENV['KUBES_EXTRA']}
@namespace = "demo"

@serviceName = name_with_extra("demo-web")
@servicePort = 80
```

## Deploy

Now, to create additional environment, it's simple:

    KUBES_EXTRA=2 kubes deploy
    KUBES_EXTRA=3 kubes deploy
    # etc

The label with the `extra` key is optional but helps with filtering the resources.

    kubectl get all,ing -l extra=2
    kubectl get all,ing -l extra=3

Example:

    $ kubectl get all,ing -l extra=2
    NAME                              READY   STATUS    RESTARTS   AGE
    pod/demo-web-2-5f8b8cbcdc-dmbjj   1/1     Running   0          78s
    pod/demo-web-2-5f8b8cbcdc-kg8hf   1/1     Running   0          78s

    NAME                 TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
    service/demo-web-2   NodePort   172.16.158.166   <none>        80:30148/TCP   78s

    NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/demo-web-2   2/2     2            2           78s

    NAME                                    DESIRED   CURRENT   READY   AGE
    replicaset.apps/demo-web-2-5f8b8cbcdc   2         2         2       79s

    NAME                                    HOSTS   ADDRESS         PORTS   AGE
    ingress.extensions/demo-web-ingress-2   *       34.120.11.136   80      79s
    $
