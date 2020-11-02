---
title: AWS Secrets Advanced
nav_text: Secrets
categories: advanced-helpers-aws
---

This covers an advanced way so that Kubernetes Secrets are created from AWS Secrets Manager in a conventional way.

## Simple Values

For example if you have these secret values:

    $ aws secretsmanager get-secret-value --secret-id demo/dev/db_user | jq '.SecretString'
    user
    $ aws secretsmanager get-secret-value --secret-id demo/dev/db_pass | jq '.SecretString'
    pass

Set up a [Kubes hook](https://kubes.guru/docs/config/hooks/kubes/).

.kubes/config/hooks/kubes.rb

```ruby
secrets = KubesAws::Secrets.new(upcase: true, prefix: "demo/dev/")
before("compile",
  label: "Get secrets from AWS Secrets Manager",
  execute: secrets,
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
<% KubesAws::Secrets.data.each do |k,v| -%>
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

## JSON Values

For example if you have these secret values:

    $ aws secretsmanager get-secret-value --secret-id demo/dev/k2 | jq '.SecretString'
    {\"a\":1,\"b\":2}"

Set up a [Kubes hook](https://kubes.guru/docs/config/hooks/kubes/).

.kubes/config/hooks/kubes.rb

```ruby
secrets = KubesAws::Secrets.new(prefix: "rails/dev/")
before("compile",
  label: "Get secrets from AWS Secrets Manager",
  execute: secrets,
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
<% k2 = JSON.load(KubesAws::Secrets.data["k2"]) %>
  a: <%= base64(k2["a"]) %>
  b: <%= base64(k2["b"]) %>
```

Produces:

```yaml
metadata:
  namespace: demo-dev
  name: demo-a4cd604a95
  labels:
    app: demo
apiVersion: v1
kind: Secret
data:
  a: MQ==
  b: Mg==
```

## Variables

These environment variables can be set:

Name | Description
---|---
AWS_SECRET_PREFIX | Prefixed used to list and filter AWS secrets. IE: `demo/dev/`.

Secrets#initialize options:

Variable | Description | Default
---|---|---
base64 | Automatically base64 encode the values. | false
upcase | Automatically upcase the Kubernetes secret data keys. | false
prefix | Prefixed used to list and filter AWS secrets. IE: `demo/dev/`. Can also be set with the `AWS_SECRET_PREFIX` env variable. The env variable takes the highest precedence. | nil

{% include helpers/base64.md %}
