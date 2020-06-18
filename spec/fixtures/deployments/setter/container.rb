name "demo-web"
labels(app: name)
namespace "default"

container(
  name: name,
  image: "nginx",
  ports: [
    containerPort: 88
  ]
)
