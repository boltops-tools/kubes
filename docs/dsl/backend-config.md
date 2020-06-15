# BackendConfig DSL

Here's an example of an BackendConfig.

.kubes/resources/demo-web/backend-config.rb

```ruby
@name = "backendconfig"
@spec = {
  timeoutSec: 40,
  connectionDraining: {
    drainingTimeoutSec: 60,
  },
  sessionAffinity: {
    affinityType: "CLIENT_IP",
  }
}
```

Running the `kubes compile` command:

    $ kubes compile
    Generated .kubes/output/demo-web/backend-config.yaml
    $

Produces:

.kubes/output/demo-web/backend-config.yaml

```yaml
---
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: my-bsc-backendconfig
spec:
  timeoutSec: 40
  connectionDraining:
    drainingTimeoutSec: 60
  sessionAffinity:
    affinityType: CLIENT_IP
```
