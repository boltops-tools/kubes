---
title: ManagedCertificate DSL
---

Here's an example of a ManagedCertificate.

.kubes/resources/web/managed_certificate.rb

```ruby
name "cert1"
domains(["cert1.example.com"])
```

Running the `kubes compile` command:

    $ kubes compile
    Generated .kubes/output/web/managed_certificate.yaml
    $

Produces:

.kubes/output/web/managed_certificate.yaml

```yaml
---
apiVersion: networking.gke.io/v1beta2
kind: ManagedCertificate
metadata:
  name: cert1
spec:
  domains:
  - cert1.example.com
```

## DSL Methods

Here's a list of more common methods:

Top-level and special fields:

* domain
* domains

{% include dsl/methods.md name="managed_certificate" %}
