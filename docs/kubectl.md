# Kubectl

Kubes calls out the `kubectl` command. You can customize the with args and hooks. Examples below:

## Args

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

.kubes/config/kubectl/hooks.rb

```ruby
before("apply",
  execute: "kubectl apply -f .kubes/shared/namespace.yaml",
)

after("delete",
  execute: "echo 'delete hook',
)
```
