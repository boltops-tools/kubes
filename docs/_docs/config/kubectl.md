---
title: Kubectl Config
---

## General

Kubes calls out the `kubectl` command. You can customize the command.

## Args

Here are some examples of customizing the kubectl args.

.kubes/config/kubectl/args.rb

```ruby
command("apply",
  args: ["--validate=true"],
)

command("delete",
  args: ["--grace-period=-1"],
)
```

## Hooks

Here are some examples of running custom hooks before and after the kubectl commands.

.kubes/config/kubectl/hooks.rb

```ruby
before("apply",
  execute: "kubectl apply -f .kubes/shared/namespace.yaml",
)

after("delete",
  execute: "echo 'delete hook',
)
```

You can use hooks to do things that may not make sense to do in the `.kubes/resources` definition. Here's an example of automatically creating the namespace.

.kubes/shared/namespace.yaml

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: demo
```

### exit on fail

By default, if the hook commands fail, then terraspace will exit with the original hook error code.  You can change this behavior with the `exit_on_fail` option.

```ruby
before("apply"
  execute: "/command/will/fail/but/will/continue",
  exit_on_fail: false,
)
```
