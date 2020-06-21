---
title: ConfigMap DSL
---

## Example

Here's an example of a ConfigMap.

.kubes/resources/web/config_map.rb

```ruby
name "demo-config-map"
data(
  database: "mongodb",
  database_uri: "mongodb://localhost:27017",
)
```

Produces:

.kubes/output/web/config_map.yaml

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-config-map
  labels:
    app: demo
  namespace: default
data:
  database: mongodb
  database_uri: mongodb://localhost:27017
```

## DSL Methods

Here's a list of more common methods:

* data
* binaryData

{% include dsl/methods.md name="config-map" %}
