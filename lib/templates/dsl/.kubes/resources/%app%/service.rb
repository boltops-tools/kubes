@name = "demo-web"
@namespace = "default"
@labels = {app: "demo-web"}
@ports = [
  port: 80,
  protocol: "TCP",
  targetPort: 80,
]

# The variables provide a convenient way to set the properties within the built service.yaml structure.
# They provide a sensible default structure.
#
# If you need more control over the service.yaml structure, you can override any of the properties with the
# setting bang methods.
#
# You have first-class citizen access to the DSL helpers methods like template and strategy methods that set
# reasonable defaults.
#
# Examples:
#
