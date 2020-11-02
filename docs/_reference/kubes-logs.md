---
title: kubes logs
reference: true
---

## Usage

    kubes logs

## Description

logs from all deployment pods


## Options

```
    [--compile], [--no-compile]  # whether or not to compile the .kube/resources
                                 # Default: true
p, [--pod=POD]                   # pod to use. IE: web
d, [--deployment=DEPLOYMENT]     # deployment name to use. IE: demo-web
c, [--container=CONTAINER]       # Container name. If omitted, the first container in the pod will be chosen
f, [--follow], [--no-follow]     # Follow logs
                                 # Default: true
    [--verbose], [--no-verbose]  
    [--noop], [--no-noop]        
```

