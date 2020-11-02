## Examples

    $ kubes new resource ingress
          create  .kubes/resources/web/ingress.yaml
    $ kubes new resource service_account
          create  .kubes/resources/shared/service_account.yaml
    $

## Supported Resources

Here's a list of some of the supported resources.

    backend_config
    config_map
    daemon_set
    deployment
    ingress
    job
    managed_certificate
    namespace
    network_policy
    pod
    role_binding
    role
    secret
    service_account
    service

Refer to the source code to all the resources that the generator supports:
https://github.com/boltops-tools/kubes/blob/master/lib/templates/new/resource/yaml
