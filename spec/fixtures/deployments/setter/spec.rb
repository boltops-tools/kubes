@name = "demo-web"
@labels = {app: "demo-web"}
@namespace = "default"

spec!(
  replicas: 3,
  selector: {matchLabels: @labels},
  strategy: strategy,
  template: template,
)
