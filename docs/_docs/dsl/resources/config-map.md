---
title: ConfigMap DSL
---

## Example

Here's an example of a ConfigMap.

.kubes/resources/shared/config_map.rb

```ruby
name "demo-config-map"
data(
  database: "mongodb",
  database_uri: "mongodb://localhost:27017",
)
```

Produces:

.kubes/output/shared/config_map.yaml

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo-config-map-cfbd534f91
  labels:
    app: demo
  namespace: default
data:
  database: mongodb
  database_uri: mongodb://localhost:27017
```

## Suffix Hash

{% include dsl/rolling_deployment.md kind="ConfigMap" %}

.kubes/output/web/deployment.yaml:

```yaml
# ..
spec:
  template:
    spec:
      containers:
      - name: demo-web
        image: nginx
        envFrom:
        - configMapRef:
            name: demo-config-map-cfbd534f91
```

{% include dsl/suffix_hash.md %}

## Files Helper

You can use a `files` helper to load ConfigMap values from one or more files.


.kubes/resources/shared/config_map.rb

```ruby
name "demo-secret"
files("files/configs.txt")
```

The `files/configs.txt` should be in the same folder as the `config_map.rb` definition.  Example:

.kubes/resources/shared/files/configs.txt

    CONFIG1=value1
    CONFIG2=value2

## DSL Methods

Here's a list of more common methods:

* data
* binaryData

{% include dsl/methods.md name="config-map" %}
