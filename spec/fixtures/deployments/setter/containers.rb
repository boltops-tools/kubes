name "demo-web"
labels(app: name)
namespace "default"

containers([{
  name: name,
  image: "nginx",
  ports: [
    containerPort: 88
  ]
},{
  name: "sidecar",
  image: "tongueroo/sinatra",
}])
