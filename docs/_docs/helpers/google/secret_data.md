---
title: Google Secrets
nav_text: Secrets Data
categories: helpers-google
---

The `google_secret_data` helper fetches secret data that is one single file from Google Secrets.

## Example

For example if you have these secret values stored as one file with multiple values separated by `=`.

    $ gcloud secrets versions access latest --secret demo-dev-secret-data
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
<%= google_secret_data("demo-dev-secret-data") %>
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

Here's an example of the available options for `google_secret_data`.

```ruby
google_secret_data("demo-#{Kubes.env}-secret-data", base64: true, ident: 2)
```
