name "demo-web"
labels(app: name)
namespace "default"

replicas 2
image "nginx"
containerPort 81
