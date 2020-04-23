@name = "demo-web"
@labels = {app: "demo-web"}
@namespace = "default"

container!([
  name: @name,
  image: "nginx",
  ports: [
    containerPort: 88
  ]
])
