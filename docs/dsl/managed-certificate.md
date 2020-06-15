# ManagedCertificate DSL

Here's an example of an managed_certificate.

.kubes/resources/demo-web/managed_certificate.rb

```ruby
@name = "cert1"
@domains = [
  "cert1.example.com"
]
```

Running the `kubes compile` command:

    $ kubes compile
    Generated .kubes/output/demo-web/managed_certificate.yaml
    $

Produces:

.kubes/output/demo-web/managed_certificate.yaml

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
