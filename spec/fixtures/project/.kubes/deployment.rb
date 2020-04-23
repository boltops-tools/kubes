@name = "demo-web"
@labels = {app: "demo-web"}
@namespace = "default"

@replicas = 2

# spec(
#   replicas: @replicas || 1,
#   selector: {matchLabels: @labels},
#   strategy: strategy,
#   template: template,
# )

containers([
  name: @name,
  image: "nginx",
  ports: [
    containerPort: 80
  ]
])
