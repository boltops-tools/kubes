---
title: Env Config
---

The `config.rb` is where you can configure Kubes settings:

.kubes/config.rb

```ruby
Kubes.configure do |config|
  config.repo = "111111111111.dkr.ecr.us-west-2.amazonaws.com/demo"
  config.logger.level = "info"
  # auto-switching
  # config.kubectl.context = "dev-cluster"
  # config.kubectl.context_keep = false
end
```

## Layering

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

For more details refer to the [Layering Docs]({% link _docs/layering.md %}).

## Auto-Switching Context

Kubes supports automatically switching the kubectl context based on `KUBES_ENV`.  Example:

    KUBES_ENV=dev  kubes deploy
    KUBES_ENV=prod kubes deploy # can use different kubectl context

So dev and prod can use different kubectl contexts based on what is configured by:

```ruby
Kubes.configure do |config|
  config.kubectl.context = "..."
end
```

For more details refer to the [Auto Context Docs]({% link _docs/misc/auto-context.md %}).