---
title: kubes new resource
reference: true
---

## Usage

    kubes new resource

## Description

Generates Kubes Kubernetes resource definition.

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


## Options

```
a, [--app=APP]    # App name
                  # Default: demo
y, [--force]      # Bypass overwrite are you sure prompt for existing files
r, [--role=ROLE]  # Role. IE: web, clock, worker, migrate, etc. Defaults to convention: web or shared when not set
t, [--type=TYPE]  # Type: dsl or yaml
                  # Default: yaml
```

