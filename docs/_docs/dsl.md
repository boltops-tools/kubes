---
title: Kubes DSL
---

Kubes supports a DSL that builds Kubernetes YAML files. The DSL substantially reduces the amount of code you have to write. Each part of the structure can be customized and overridden.

Generally:

* The DSL methods behave as reader methods when no arguments are passed to it.
* The DSL methods behave as writer methods when arguments are passed to it.

## Support Resources

* [BackendConfig]({% link _docs/dsl/backend-config.md %})
* [Deployment]({% link _docs/dsl/deployment.md %})
* [Service]({% link _docs/dsl/service.md %})
* [Ingress]({% link _docs/dsl/ingress.md %})
* [ManagedCertificate]({% link _docs/dsl/managed-certificate.md %})

For resources, that are not supported, use [YAML]({% link _docs/yaml.md %}) instead. You can use a mix of DSL and YAML definitions in the `.kubes/resources` folder.
