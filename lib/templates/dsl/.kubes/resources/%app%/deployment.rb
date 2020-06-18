name "demo-web"
labels(app: name)
namespace "default"

replicas 1
image built_image # IE: user/demo:kubes-2020-06-13T19-55-16-43afc6e

# More docs: kubes.guru/docs/dsl/deployment/
