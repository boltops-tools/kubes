---
title: Google Service Account
nav_text: Service Account
categories: helpers-google
---

## Service Accounts

You can automatically create the Google Service Account associated with the [GKE Workload Identity](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity).

Here's a Kubes hook that creates a service account:

.kubes/config/hooks/kubes.rb

```ruby
service_account = KubesGoogle::ServiceAccount.new(
  app: "demo",
  namespace: "demo-#{Kubes.env}", # defaults to APP-ENV when not set. IE: demo-dev
  roles: ["cloudsql.client", "secretmanager.viewer"], # defaults to empty when not set
)
before("apply",
  label: "create service account",
  execute: service_account,
)
```

The corresponding Kubernetes Service account looks like this:

.kubes/resources/shared/service_account.yaml

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    iam.gke.io/gcp-service-account: demo-<%= Kubes.env %>@<%= ENV['GOOGLE_PROJECT'] %>.iam.gserviceaccount.com
  name: demo
  labels:
    app: demo
```

The role permissions are currently always added to the existing permissions. So removing roles that were previously added does not remove them.

ServiceAccount#initialize options:

Variable | Description | Default
---|---|---
app | The app name. It's used to set other variables conventionally. This is required. | nil
gsa | The Google Service Account name. The conventional name is APP-ENV. IE: demo-dev. | APP-ENV
ksa | The Kubernetes Service Account name. The conventional name is APP. IE: demo | APP
namespace | The Kubernetes namespace. Defaults to the APP-ENV. IE: demo-dev. | APP-ENV
roles | Google IAM roles to add. This adds permissions to the Google service account. | []
