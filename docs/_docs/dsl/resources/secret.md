---
title: Secret
categories: dsl
---

## Example

Here's an example of a Secret.

.kubes/resources/shared/secret.rb

```ruby
name "demo-secret"
data(
  username: base64("user"),
  password: base64("pass"),
)
```

Produces:

.kubes/output/shared/service.yaml

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: demo-secret-cfbd534f91
  labels:
    app: demo
  namespace: default
data:
  username: dXNlcg==
  password: cGFzcw==
```

## Suffix Hash

{% include dsl/rolling_deployment.md kind="Secret" %}

.kubes/output/web/deployment.yaml:

```yaml
# ..
spec:
  template:
    spec:
      containers:
      - name: demo-shared
        image: nginx
        envFrom:
        - secretRef:
            name: demo-secret-cfbd534f91
```

{% include dsl/suffix_hash.md %}

## Files Helper

You can use a `files` helper to load secrets values from one or more files.


.kubes/resources/shared/secret.rb

```ruby
name "demo-secret"
files("files/secrets.txt")
```

The `files/secrets.txt` should be in the same folder as the `secret.rb` definition.  Example:

.kubes/resources/shared/files/secret.txt

    SECRET1=value1
    SECRET2=value2

You do not have to worry about base64 encoding the values. Kubes automatically base64 encodes the values.

## DSL Methods

Here's a list of more common methods:

* data
* stringData
* type

{% include dsl/methods.md name="secret" %}
