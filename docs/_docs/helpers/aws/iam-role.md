---
title: AWS IAM Role
nav_text: IAM Role
categories: helpers-aws
---

You can automatically create the IAM Role associated with the Kubernetes Service Account, covered in [Introducing fine-grained IAM roles for service accounts](https://aws.amazon.com/blogs/opensource/introducing-fine-grained-iam-roles-service-accounts/).

Here's a Kubes hook that creates an IAM Role:

.kubes/config/hooks/kubes.rb

```ruby
iam_role = KubesAws::IamRole.new(
  app: "demo",
  namespace: "demo-#{Kubes.env}", # defaults to APP-ENV when not set. IE: demo-dev
  managed_policies: ["AmazonS3ReadOnlyAccess", "AmazonSSMReadOnlyAccess"], # defaults to empty when not set
  inline_policies: [:secrets_read_only], # See Secrets Read Only Inline Policy at the bottom
)
before("apply",
  label: "create iam role",
  execute: iam_role,
)
KubesAws::IamRole.role_arn = iam_role.arn # used in .kubes/resources/shared/service_account.yaml
```

The corresponding Kubernetes Service account looks like this:

.kubes/resources/shared/service_account.yaml

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    eks.amazonaws.com/role-arn: <%= KubesAws::IamRole.role_arn %>
  name: demo
  labels:
    app: demo
```

The role policy permissions are currently always added to the existing permissions. So removing roles that were previously added does not remove them.

IamRole#initialize options:

Variable | Description | Default
---|---|---
app | The app name. It's used to set other variables conventionally. This is required. | nil
ksa | The Kubernetes Service Account name. The conventional name is APP. IE: demo | APP
namespace | The Kubernetes namespace. Defaults to the APP-ENV. IE: demo-dev. | APP-ENV
policies | IAM policies to add. This adds permissions to the IAM Role. | []
role_name | The IAM Role name. The conventional name is APP-ENV. IE: demo-dev. | APP-ENV

## OpenID Connect Provider

The `KubesAws::IamRole` class also automatically creates the OpenID Connect Provider if it doesn't already exist.

## Secrets Read-Only Inline Policy

Note the the `:secrets_read_only` is a way to generate an Inline Policy that represents read-only access for Secrets. Kubes does this since there's no managed policy for this yet. For example:

```ruby
inline_policies: [:secrets_read_only]
```

Is the same as:

```ruby
inline_secrets_read_only = {
  policy_document: {
    Version: "2012-10-17",
    Statement: {
      Effect: "Allow",
      Action: [
        "secretsmanager:Describe*",
        "secretsmanager:Get*",
        "secretsmanager:List*"
      ],
      Resource: "*"
    }
  },
  policy_name: "SecretsReadOnly",
}
iam_role = KubesAws::IamRole.new(
  app: "rails",
  cluster: "dev-cluster",
  namespace: "rails-#{Kubes.env}", # defaults to APP-ENV when not set. IE: rails-dev
  managed_policies: ["AmazonS3ReadOnlyAccess", "AmazonSSMReadOnlyAccess"], # defaults to empty when not set
  inline_policies: [inline_secrets_read_only],
)
```