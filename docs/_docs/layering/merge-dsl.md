---
title: DSL Merge Behavior
nav_text: DSL Merge
category: layering
order: 4
---

Generally, the merge should behave as expected. For example, map or Hash fields are merged together from multiple layers. Strings are simply replaced.

## Hash Example

.kubes/resources/base/all.rb

```ruby
labels(app: "demo")
# ...
```

.kubes/resources/base/all/env.rb

```ruby
labels(env: Kubes.env)
# ...
```

.kubes/resources/web/deployment.rb

```ruby
labels(role: "web")
# ...
```

Layering results in:

.kubes/output/web/deployment.yaml

```yaml
metadata:
  labels:
    app: demo
    env: dev
    role: web
# ...
```

## Hash Merge Behavior Override

You can override the merge behavior with the `_mode` key.

.kubes/resources/web/deployment.rb

```ruby
labels(role: "web", _mode: "reset")
# ...
```

This will completely reset the labels and result in:

```yaml
metadata:
  labels:
    role: web
# ...
```

## String Example

The merging of simple String is a straightforward replacement.

.kubes/resources/web/deployment.rb

```ruby
image docker_image # IE: user/demo:kubes-2020-06-13T19-55-16-43afc6e
# ...
```

.kubes/resources/web/deployment/prod.rb

```ruby
image "nginx:prod-v1"
# ...
```

Results in:

.kubes/output/web/deployment.yaml

```yaml
spec:
  # ...
  template:
    spec:
      containers:
      - image: nginx:prod-v1
        name: demo-web
  # ...
```

{% include dsl/methods.md name="backend_config" %}
