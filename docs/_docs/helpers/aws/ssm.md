---
title: AWS SSM Parameters
nav_text: SSM
categories: helpers-aws
---

For example if you have these secret values:

    $ aws ssm get-parameter --name /demo/development/db_user --with-decryption | jq '.Parameter.Value'
    user
    $ aws ssm get-parameter --name /demo/development/db_pass --with-decryption | jq '.Parameter.Value'
    pass

Set up a [Kubes hook](https://kubes.guru/docs/config/hooks/kubes/).

.kubes/config/hooks/kubes.rb

```ruby
ssm = KubesAws::SSM.new(upcase: true, prefix: "/demo/development/")
before("compile",
  label: "Get secrets from AWS SSM Manager",
  execute: ssm,
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
<% KubesAws::SSM.data.each do |k,v| -%>
  <%= k %>: <%= base64(v) %>
<% end -%>
```

This results in AWS secrets with the prefix the `demo/dev/` being added to the Kubernetes secret data.  The values are automatically base64 encoded. Produces:

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
AWS_SSM_PREFIX | Prefixed used to list and filter AWS SSM Parameters. IE: `demo/dev/`.

Secrets#initialize options:

Variable | Description | Default
---|---|---
base64 | Automatically base64 encode the values. | false
upcase | Automatically upcase the Kubernetes secret data keys. | false
prefix | Prefixed used to list and filter AWS secrets. IE: `demo/dev/`. Can also be set with the `AWS_SECRET_PREFIX` env variable. The env variable takes the highest precedence. | nil

{% include helpers/base64.md %}