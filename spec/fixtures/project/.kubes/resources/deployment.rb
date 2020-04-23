@name = "demo-web"
@labels = {app: "demo-web"}
@namespace = "default"

@replicas = 2
@image = "nginx"
@container_port = 81

# container!([
#   name: @name,
#   image: "nginx",
#   ports: [
#     containerPort: 80
#   ]
# ])

# spec!(
#   replicas: @replicas || 1,
#   selector: {matchLabels: @labels},
#   strategy: strategy,
#   test: "me",
#   template: template,
# )

# containers!([
#   name: @name,
#   image: "nginx",
#   ports: [
#     containerPort: 80
#   ]
# ])
