---
title: Google Secrets
nav_text: Secrets
categories: helpers-google
---

The `google_secret` helper fetches secret data from Google Secrets.

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
  PASS: <%= google_secret("demo-#{Kubes.env}-PASS") %>
  USER: <%= google_secret("demo-#{Kubes.env}-USER") %>
```

The values are automatically base64 encoded.

For example if you have these secret values:

    $ gcloud secrets versions access latest --secret demo-dev-USER
    test1
    $ gcloud secrets versions access latest --secret demo-dev-PASS
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

## Variables

These environment variables can be set:

Name | Description
---|---
GOOGLE_PROJECT | Google project id. This is required.

## Base64 Option

The value is automatically base64 encoded. You can set the `base64` option to turn on and off the automated base64 encoding.

```ruby
google_secret("demo-#{Kubes.env}-USER", base64: true)  # default is base64=true
google_secret("demo-#{Kubes.env}-PASS", base64: false)
```

{% include helpers/base64.md %}
