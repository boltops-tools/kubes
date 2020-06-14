# Customizing

Each part of the structure can be customized and overridden. You have full control over the compiled YAML.

Here's an example of overriding with `metadata!` and `spec!`

```ruby
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
```


If you only have one container for the pod, which is common, you can use `container!`:

```ruby
@name = "demo-web"
@labels = {app: "demo-web"}
@namespace = "default"
container!(
  name: @name,
  image: "nginx",
)
```

Here's another example of overriding with with multiple `containers!`:

```ruby
@name = "demo-web"
@labels = {app: "demo-web"}
@namespace = "default"
containers!([
  name: @name,
  image: "nginx",
])
```
