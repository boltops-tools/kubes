---
title: kubes get
reference: true
---

## Usage

    kubes get [ROLE] [RESOURCE]

## Description

Get Kubernetes resource using the compiled YAML files


## Options

```
    [--image=IMAGE]                  # override image
    [--compile], [--no-compile]      # whether or not to compile the .kube/resources
                                     # Default: true
o, [--output=OUTPUT]                 # Output format: json|yaml|wide|name
    [--show-pods], [--no-show-pods]  # Also show pods from deployments
                                     # Default: true
    [--verbose], [--no-verbose]      
    [--noop], [--no-noop]            
```

