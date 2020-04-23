@name = "nginx"
@labels = {app: "nginx"}
@namespace = "default"

containers([
  name: @name,
  image: "nginx",
  ports: [
    containerPort: 80
  ]
])
