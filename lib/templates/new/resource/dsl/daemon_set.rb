name "<%= app %>"
labels("app": "<%= app %>")
updateStrategy(
  type: "RollingUpdate",
  rollingUpdate: {
    maxUnavailable: 1
  }
)
# annotations(
#   "*scheduler**.alpha.kubernetes.io/critical-pod": '*'
# )
