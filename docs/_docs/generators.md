---
title: Generators
---

Kubes ships with a few generators to help you get building with Kubernetes quickly.  The generated  starter YAML should be modified and customized for your needs.

## Examples

Here are a few examples:

    $ kubes new resource ingress
          create  .kubes/resources/web/ingress.yaml
    $ kubes new resource service_account
          create  .kubes/resources/shared/service_account.yaml
    $

Use `-h` to see the cli options:

    kubes new resource -h

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

Refer to the [source code](https://github.com/boltops-tools/kubes/blob/master/lib/templates/new/resource/yaml) to all the resources that the generator supports.
