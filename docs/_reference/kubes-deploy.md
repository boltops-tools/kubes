---
title: kubes deploy
reference: true
---

## Usage

    kubes deploy [APP] [RESOURCE]

## Description

Deploy to Kubernetes: docker build/push, kubes compile, and kubectl apply

## Examples

Deploy all resources in .kubes/resources/demo-web

    kubes deploy demo-web

Deploy specific resource, like .kubes/resources/demo-web/deployment.rb

    kubes deploy demo-web deployment
    kubes deploy demo-web service


## Options

```
[--image=IMAGE]              # override image
[--build], [--no-build]      # whether or not to build docker image
                             # Default: true
[--verbose], [--no-verbose]  
[--noop], [--no-noop]        
```

