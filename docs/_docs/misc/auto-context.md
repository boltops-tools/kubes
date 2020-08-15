---
title: Auto Context
---

Kubes supports automatically switching the kubectl context based on the `KUBES_ENV`.  Since Kubernetes contexts are composed of three things: cluster, namespace, and user; this feature allows you to target any of them on a per `KUBES_ENV` basis.

## Auto Context

The dev and prod environments can use different kubectl contexts based on what is configured by the Kubes config.rb:

```ruby
Kubes.configure do |config|
  config.kubectl.context = "..."
  # config.kubectl.context_keep = true # keep the context after switching
end
```

You can override configs on a per-env basis with `config/env` files. Examples:

.kubes/config/env/dev.rb

```ruby
Kubes.configure do |config|
  config.repo = "222222222222.dkr.ecr.us-west-2.amazonaws.com/demo"
  config.kubectl.context = "dev-cluster"
end
```

.kubes/config/env/prod.rb

```ruby
Kubes.configure do |config|
  config.repo = "333333333333.dkr.ecr.us-west-2.amazonaws.com/demo"
  config.kubectl.context = "prod-cluster"
end
```

## Deploy

With this setup, when you deploy with kubes, it will automatically switch the kubectl context based on `KUBES_ENV`.  Example:

    KUBES_ENV=dev  kubes deploy # to dev-cluster context
    KUBES_ENV=prod kubes deploy # to prod-cluster context

## context_keep Option

Setting `context_keep=true` option means after the context it switched, it stays switched. If `context_keep=false`, then Kubes will switch back to the previous context.
