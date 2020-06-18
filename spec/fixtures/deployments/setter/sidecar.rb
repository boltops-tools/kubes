name "demo-web"
labels(app: name)

image "nginx"

sidecar(
  name: "sidecar",
  image: "tongueroo/sinatra",
  ports: [
    containerPort: 88
  ]
)
