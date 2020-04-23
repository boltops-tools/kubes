@name = "demo-web"
@labels = {app: "demo-web"}

@image = "nginx"

sidecar!(
  name: "sidecar",
  image: "tongueroo/sinatra",
  ports: [
    containerPort: 88
  ]
)
