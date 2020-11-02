---
title: AWS SSM Parameters
nav_text: SSM
categories: helpers-aws
---

The `aws_ssm` helper fetches data from AWS SSM Parameter Store.

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
  PASS: <%= aws_ssm("/demo/#{Kubes.env}/PASS") %>
  USER: <%= aws_ssm("/demo/#{Kubes.env}/USER") %>
```

For example if you have these ssm parameter values:

    $ aws ssm get-parameter --name /demo/dev/PASS --with-decryption | jq '.Parameter.Value'
    test1
    $ aws ssm get-parameter --name /demo/dev/USER --with-decryption | jq '.Parameter.Value'
    test2

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
aws_ssm("/demo/#{Kubes.env}/USER", base64: true)  # default is base64=true
aws_ssm("/demo/#{Kubes.env}/PASS", base64: false)
```

{% include helpers/base64.md %}
