---
title: Merge Options
---

Underneath the hood, Kubes uses the [danielsdeleo/deep_merge](https://github.com/danielsdeleo/deep_merge) library to merge layers together. You can control the merge behavior options with [config.merger.options]({% link _docs/config/reference.md %}).

The default merge options is:

    {overwrite_arrays: true}

You can control the merge behavior by setting:

.kubes/config.rb

```ruby
Kubes.configure do |config|
  # ...
  config.merger.options = {overwrite_arrays: false}
end
```

See the [danielsdeleo/deep_merge](https://github.com/danielsdeleo/deep_merge) docs for the different options.

## Example of overwrite_arrays false

An example of where you might want to use `{overwrite_arrays: false}` is if you are using YAML and want a base sidecar container in all of your deployments.

.kubes/resources/base/deployment.yaml

```yaml
spec:
  template:
    spec:
      containers:
      - name: sidecar
        image: sidecar-image
```

.kubes/resources/web/deployment.yaml

```yaml
spec:
  template:
    metadata:
      labels:
        role: web
    spec:
      containers:
      - name: web
        image: <%= docker_image %>
```

Produces:

```yaml
# ...
spec:
  template:
    metadata:
      labels:
        role: web
    spec:
      containers:
      - name: sidecar
        image: sidecar-image
      - name: web
        image: gcr.io/boltops-learn/demo:kubes-2021-10-21T18-06-48
# ...
```

However, using this merge behavior will also add additional ports if you are assigning a `targetPort` in the DSL. See:

* [DSL in service creates always default port 80 #45](https://github.com/boltops-tools/kubes/issues/45)
* [use deep_merge overwrite_arrays option #48](https://github.com/boltops-tools/kubes/pull/48)

Will welcome PRs for improvements.
