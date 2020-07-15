---
title: ServiceAccount
categories: dsl
---

## Example

Here's an example of a ServiceAccount.

.kubes/resources/shared/service_account.rb

```ruby
name "demo"
```

Produces:

.kubes/output/shared/service_account.yaml

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: demo
```

## DSL Methods

Here's a list of more common methods:

Top-level methods:

* automountServiceAccountToken
* imagePullSecrets
* secrets

{% include dsl/methods.md name="service_account" %}
