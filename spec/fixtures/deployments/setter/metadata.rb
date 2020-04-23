@name = "demo-web"
@labels = {app: "demo-web"}
@namespace = "default"

metadata!(
  name: @name,
  labels: @labels.merge(label2: "value2"),
  namespace: @namespace,
)
spec!(
  replicas: 3,
  selector: {matchLabels: @labels},
  strategy: strategy,
  template: template,
)
