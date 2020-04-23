@name = "demo-web"
@labels = {app: "demo-web"}
@namespace = "default"

containers!([{
  name: @name,
  image: "nginx",
  ports: [
    containerPort: 88
  ]
},{
  name: "sidecar",
  image: "tongueroo/sinatra",
}])
