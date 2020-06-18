name "demo-web"
labels(app: name)
namespace "default"

spec(
  replicas: 3,
  selector: {matchLabels: labels},
  strategy: strategy,
  template: template,
)
