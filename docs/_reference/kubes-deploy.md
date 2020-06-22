---
title: kubes deploy
reference: true
---

## Usage

    kubes deploy [APP] [RESOURCE]

## Description

Deploy to Kubernetes: docker build/push, kubes compile, and kubectl apply

## Examples

Deploy all resources in .kubes/resources/web

    kubes deploy web

Deploy specific resource, like .kubes/resources/web/deployment.rb

    kubes deploy web deployment
    kubes deploy web service


## Options

```
[--image=IMAGE]              # override image
[--build], [--no-build]      # whether or not to build docker image
                             # Default: true
[--verbose], [--no-verbose]  
[--noop], [--no-noop]        
```

