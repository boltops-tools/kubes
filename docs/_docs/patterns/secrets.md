---
title: Secrets
nav_text: Secrets
categories: patterns
---

A Google Secrets helper currently supported.

## Set Up Kubes Hook

Set up a [Kubes hook]({% link _docs/config/hooks/kubes.md %}).

.kubes/config/hooks/kubes.rb

```ruby
ENV['GCP_SECRET_PREFIX'] ||= 'projects/686010496118/secrets/demo-dev-'
before("compile",
  execute: KubesGoogle::Secrets.new(upcase: true)
)
```

Then set the secrets in the YAML:

.kubes/resources/shared/secret.yaml

```
apiVersion: v1
kind: Secret
metadata:
  name: demo
  labels:
    app: demo
data:
<% KubesGoogle::Secrets.data.each do |k,v| -%>
  <%= k %>: <%= v %>
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

These environment variables can be set:

Name | Description
---|---
GCP_SECRET_PREFIX | Prefixed used to list and filter Google secrets. IE: `projects/686010496118/secrets/demo-dev-`.
GOOGLE_PROJECT | Google project id.

Secrets#initialize options:

Variable | Description | Default
---|---|---
upcase | Automatically upcase the Kubernetes secret data keys. | false
prefix | Prefixed used to list and filter Google secrets. IE: `projects/686010496118/secrets/demo-dev-`. Can also be set with the `GCP_SECRET_PREFIX` env variable. The env variable takes the highest precedence. | nil

Note, Kubernetes secrets are only base64 encoded. So users who have access to read Kubernetes secrets will be able to decode and get the value trivially. Depending on your security posture requirements, this may or may not suffice.

The Google helpers are provided by the [boltops-tools/kubes_google](https://github.com/boltops-tools/kubes_google) library. For more details, check out its README.
