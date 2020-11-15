---
title: YAML Multiple Resources with Multiple Files
---

You can also create multiple resources of same kind by appending a dash followed by anything. Example:

    .kubes
    └── resources
        └── web
            ├── deployment-1.yaml
            ├── deployment-2.yaml
            ├── service-1.yaml
            └── service-2.yaml

Only words before the dash are used to infer the resource kind.

Filename | Resource Kind
--- | ---
deployment-1.yaml | Deployment
deployment-2.yaml | Deployment
service-1.yaml | Service
service-2.yaml | Service

