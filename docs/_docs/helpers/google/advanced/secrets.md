---
title:  Advanced Google Secrets
nav_text: Secrets
categories: advanced-helpers-google
---

This covers an advanced way so that Kubernetes Secrets are created from Google Secrets in a conventional way.

Set up a [Kubes hook](https://kubes.guru/docs/config/hooks/kubes/).

.kubes/config/hooks/kubes.rb

```ruby
before("compile",
  execute: KubesGoogle::Secrets.new(upcase: true, prefix: 'projects/686010496118/secrets/demo-dev-')
)
```

Then set the secrets in the YAML:

.kubes/resources/shared/secret.yaml

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: demo
  labels:
    app: demo
data:
<% KubesGoogle::Secrets.data.each do |k,v| -%>
  <%= k %>: <%= base64(v) %>
<% end -%>
```

This results in Google secrets with the prefix the `demo-dev-` being added to the Kubernetes secret data.  The values are automatically base64 encoded.

For example if you have these secret values:

    $ gcloud secrets versions access latest --secret demo-dev-db_user
    test1
    $ gcloud secrets versions access latest --secret demo-dev-db_pass
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
  db_pass: dGVzdDEK
  db_user: dGVzdDIK
```

## Variables

These environment variables can be set:

Name | Description
---|---
GCP_SECRET_PREFIX | Prefixed used to list and filter Google secrets. IE: `projects/686010496118/secrets/demo-dev-`.
GOOGLE_PROJECT | Google project id.

Secrets#initialize options:

Variable | Description | Default
---|---|---
base64 | Automatically base64 encode the values. | false
upcase | Automatically upcase the Kubernetes secret data keys. | false
prefix | Prefixed used to list and filter Google secrets. IE: `projects/686010496118/secrets/demo-dev-`. Can also be set with the `GCP_SECRET_PREFIX` env variable. The env variable takes the highest precedence. | nil

{% include helpers/base64.md %}