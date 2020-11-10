---
title: Kubes Hooks
nav_text: Kubes
categories: hooks
---

You can use hooks to run scripts at specific steps of the `kubes deploy` lifecycle.

## Lifecycle Hooks

Hook | Description
---|---
compile | When kubes compiles the `.kubes/resources` to `.kubes/output`.
apply | When kubes runs all the `kubectl apply` commands.
delete | When kubes runs all the `kubectl delete` commands.
prune | When kubes prunes. IE: To clean old secrets.

## Lifecycle At Kubes Level

These lifecycle points occur at a higher-level than the `kubectl` commands. Here's an example to help explain:

    $ kubes apply
    => kubectl apply -f .kubes/output/shared/namespace.yaml
    => kubectl apply -f .kubes/output/web/service.yaml
    => kubectl apply -f .kubes/output/web/deployment.yaml
    $

Kubes calls out to `kubectl apply` 3 times for each resource kind.

The kubes hooks run before and after **all** the `kubectl apply` commands. So the hook only runs once.

    $ kubes apply
    # kubes apply before hook <= HERE
    => kubectl apply -f .kubes/output/shared/namespace.yaml
    => kubectl apply -f .kubes/output/web/service.yaml
    => kubectl apply -f .kubes/output/web/deployment.yaml
    # kubes apply after hook  <= HERE
    $

## Example

.kubes/config/hooks/kubes.rb

```ruby
before("apply",
  execute: "echo 'kubes before apply hook'",
)

after("apply",
  execute: "echo 'kubes after apply hook'",
)
```

Example results:

    $ kubes apply
    Running kubes before apply hook.
    => echo 'kubes before apply hook'
    kubes before apply hook
    => kubectl apply -f .kubes/output/shared/namespace.yaml
    => kubectl apply -f .kubes/output/web/service.yaml
    => kubectl apply -f .kubes/output/web/deployment.yaml
    Running kubes after apply hook.
    => echo 'kubes after apply hook'
    kubes after apply hook
    $

{% include config/hooks/options.md command="kubes" %}
