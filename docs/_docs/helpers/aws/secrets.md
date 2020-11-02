---
title: AWS Secrets
nav_text: Secrets
categories: helpers-aws
---

The `aws_secret` helper fetches secret data from AWS Secrets Manager.

## Example

.kubes/resources/shared/secret.yaml

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: demo
  labels:
    app: demo
data:
  PASS: <%= aws_secret("demo-#{Kubes.env}-PASS") %>
  USER: <%= aws_secret("demo-#{Kubes.env}-USER") %>
```

For example if you have these secret values:

    $ aws secretsmanager get-secret-value --secret-id demo-dev-PASS | jq '.SecretString'
    test1
    $ aws secretsmanager get-secret-value --secret-id demo-dev-USER | jq '.SecretString'
    test2
    $

.kubes/output/shared/secret.yaml

```yaml
metadata:
  namespace: demo
  name: demo-2a78a13682
  labels:
    app: demo
apiVersion: v1
kind: Secret
data:
  PASS: dGVzdDEK
  USER: dGVzdDIK
```

The values are automatically base64 encoded.

## Base64 Option

The value is automatically base64 encoded. You can set the `base64` option to turn on and off the automated base64 encoding.

```ruby
aws_secret("demo-#{Kubes.env}-USER", base64: true)  # default is base64=true
aws_secret("demo-#{Kubes.env}-PASS", base64: false)
```

{% include helpers/base64.md %}
