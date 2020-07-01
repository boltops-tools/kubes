name "demo-web"
labels(app: name)
namespace "default"

replicas 2
image "nginx"
containerPort 80

# More examples:
# container([
#   name: name,
#   image: "nginx",
#   ports: [
#     containerPort: 80
#   ]
# ])

# spec(
#   replicas: replicas || 1,
#   selector: {matchLabels: labels},
#   strategy: strategy,
#   test: "me",
#   template: template,
# )

# containers([
#   name: name,
#   image: "nginx",
#   ports: [
#     containerPort: 80
#   ]
# ])
