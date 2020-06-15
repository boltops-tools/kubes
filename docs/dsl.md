## Deployment DSL

The Kubes DSL builds Kubenetes YAML files with a reasonable defaults. The support resources are:

* [Deployment](dsl/deployment.md)
* [Service](dsl/service.md)
* [Ingress](dsl/ingress.md)
* [ManagedCertificate](dsl/managed-certificate.md)

For resources, that are not supported, use [YAML](yaml.md) instead. You can use a mix of DSL and YAML definitions in the `.kubes/resources` folder.

## Further Customizations

Each part of the structure can be customized and overriden. Refer to [DSL Customizations](dsl/customizations.md)
