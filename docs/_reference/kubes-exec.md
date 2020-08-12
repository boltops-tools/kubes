---
title: kubes exec
reference: true
---

## Usage

    kubes exec

## Description

Exec into the latest container from the deployment

The exec command finds the latest pod from the deployment and runs `kubectl exec -ti POD bash` to get you into it. It spares you from having to manually find and type it.

## Examples

    kubes exec
    kubes exec sh
    kubes exec ls -l

## Multiple Deployments

If you have have multiple deployments in your `.kubes/resources` then the command will use the first deployment by default. You can specify the specfic deployment with the `--name` or `-n` option.  Examples:

    kubes exec --name web
    kubes exec -n web
    kubes exec -n clock
    kubes exec -n worker
    kubes exec -n web sh
    kubes exec -n web ls -l

## Multiple Pod Containers

If you have have multiple containers in your pod. You can specify the specfic container with the `--container` or `-c` option.  Examples:

    kubes exec --name web


## Options

```
    [--compile], [--no-compile]  # whether or not to compile the .kube/resources
                                 # Default: true
n, [--name=NAME]                 # deployment name to use. IE: demo-web
c, [--container=CONTAINER]       # Container name. If omitted, the first container in the pod will be chosen
    [--verbose], [--no-verbose]  
    [--noop], [--no-noop]        
```

