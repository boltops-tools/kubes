---
title: YAML Multiple Resources
---

Kubes encourages a structure with files that matches the resource kind. Example:

    .kubes/resources
    └── web
        ├── deployment.yaml
        └── service.yaml

This structure is nicely organized and covers 80% of use cases. An astute user may point out that this struture assumes one resource of each kind.

Next, we'll cover how to create multiple resource of the same kinds.

## Multiple Resources in Same YAML

You can simply define multiple resources in th same YAML file. Conventionally, you should name the resource files with plural names. An example helps explain:

    .kubes/resources
    └── deployments.yaml

.kubes/resources/web/deployments.yaml

```yaml
- apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: web-1
    labels:
      role: web
  spec:
    selector:
      matchLabels:
        role: web
    template:
      metadata:
        labels:
          role: web
      spec:
        containers:
        - name: web
          image: <%= docker_image %>
- apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: web-2
    labels:
      role: web
  spec:
    selector:
      matchLabels:
        role: web
    template:
      metadata:
        labels:
          role: web
      spec:
        containers:
        - name: web
          image: <%= docker_image %>
```

Notice that the YAML contains an Array of definitions now.

## Layering

Layering works just fine with multiple resource definitions. The layering is processed on each item of the Array.

Notes:

* The layering definitions for the pre layers must be in singular form.
* The layering definitions for the post layers must be in a folder with plural form, but define a singular resource override.
* Resources in the main "middle" layer is the only one that allows for multiple resource definitions.

Multiple resources layering structure.

    .kubes/resources/
    ├── base
    │   ├── all.rb         # SINGULAR
    │   └── deployment.rb  # SINGULAR
    └── web
        ├── deployments    # PLURAL
        │   ├── dev.rb     # SINGULAR
        │   └── prod.rb    # SINGULAR
        └── deployments.rb # PLURAL

The main difference is the pluralized filenames.
