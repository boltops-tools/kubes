@name = "demo-web"
@labels = {app: "demo-web"}
@namespace = "default"

@replicas = 1
@image = built_image # IE: tongueroo/demo-web:kubes-2020-06-13T19-55-16-43afc6e

# The variables provide a convenient way to set the properties within the built deployment.yaml structure.
# They provide a sensible default structure.
#
# If you need more control over the deployment.yaml structure, you can override any of the properties with the
# setting bang methods.
#
# You have first-class citizen access to the DSL helpers methods like template and strategy methods that set
# reasonable defaults.
#
# Examples:
#
# spec!(
#   replicas: @replicas || 1,
#   selector: {matchLabels: @labels},
#   strategy: strategy,
#   test: "me",
#   template: template,
# )
#
# container!([
#   name: @name,
#   image: "nginx",
#   ports: [
#     containerPort: 80
#   ]
# ])
#
# containers!([
#   name: @name,
#   image: "nginx",
#   ports: [
#     containerPort: 80
#   ]
# ])
