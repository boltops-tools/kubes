---
title: AWS Secrets
nav_text: Secrets Data
categories: helpers-aws
---

The `aws_secret_data` helper fetches secret data that is one single file from AWS Secrets.

## Example

For example if you have these secret values stored as one file with multiple values separated by `=`.

    $ aws secretsmanager get-secret-value --secret-id demo-dev-secret-data | jq '.SecretString'
    KEY1=secretvalue1
    KEY2=secretvalue2

Kubes can fetch the secret data and base64 encode the values properly.  Example:

.kubes/resources/shared/secret.yaml

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: demo
  labels:
    app: demo
data:
<%= aws_secret_data("demo-dev-secret-data") %>
```

Notice how the text is idented properly by 2 spaces and the values are automatically base64 encoded.

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
  KEY1: c2VjcmV0dmFsdWUx
  KEY2: c2VjcmV0dmFsdWUy
```

## Options

Here's an example of the available options for `aws_secret_data`.

```ruby
aws_secret_data("demo-#{Kubes.env}-secret-data", base64: true, ident: 2)
```
