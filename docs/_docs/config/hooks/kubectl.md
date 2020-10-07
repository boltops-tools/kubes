---
title: Kubectl Hooks
nav_text: Kubectl
categories: hooks
---

You can use hooks to run scripts at any part of the `kubectl` commands. Here's an example of running a script before and after the `kubectl apply` command for the `web/deployment` resource.

.kubes/config/hooks/kubectl.rb

```ruby
before("apply",
  on: "web/deployment",
  execute: "echo 'before apply hook test'",
)

after("delete",
  on: "web/deployment",
  execute: "echo 'after delete hook test'",
)
```

## on option

The `on` option is important. If it is not set, then the hook script will run on every `kubectl` command. So given this hook definition:

```ruby
before("apply",
  # Note how the on option is not set
  execute: "echo 'before apply hook test'",
)
```

With these resource definition files:

    .kubes/resources/shared/namespace.yaml
    .kubes/resources/web/deployment.yaml
    .kubes/resources/web/web.yaml

The hook script will run **3** times.

    $ kubes apply
    # before apply hook test <= HERE 1
    => kubectl apply -f .kubes/output/shared/namespace.yaml
    # before apply hook test <= HERE 2
    => kubectl apply -f .kubes/output/web/service.yaml
    # before apply hook test <= HERE 3
    => kubectl apply -f .kubes/output/web/deployment.yaml
    $

This is probably not what you want.  So it is important to use the `on` option to scope when to run your hook like so:

```ruby
before("apply",
  on: "web/deployment",
  execute: "echo 'before apply hook test'",
)
```

The hook script will run **1** time for the `.kubes/resources/web/deployment.yaml`:

    $ kubes apply
    => kubectl apply -f .kubes/output/shared/namespace.yaml
    => kubectl apply -f .kubes/output/web/service.yaml
    # before apply hook test <= HERE
    => kubectl apply -f .kubes/output/web/deployment.yaml
    $

The `on` option is used to match the path the gets applied: .kubes/resources/**web/deployment**.yaml

## exit on fail

By default, if the hook commands fail, then terraspace will exit with the original hook error code.  You can change this behavior with the `exit_on_fail` option.

```ruby
before("apply"
  on: "web/deployment",
  execute: "/command/will/fail/but/will/continue",
  exit_on_fail: false,
)
```

{% include config/hooks/options.md command="kubectl" %}
