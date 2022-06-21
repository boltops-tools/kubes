## Config

The `config.rb` is where you can configure Kubes settings.

.kubes/config.rb

```ruby
Kubes.configure do |config|
  config.repo = "112233445566.dkr.ecr.us-west-2.amazonaws.com/demo" # may be gcr.io/project-123/demo
  config.logger.level = "info"
  # auto-switching
  # config.kubectl.context = "dev-cluster"
end
```

This is where the `--repo` from `kubes init` got saved.  The other options are covered in the [Env Config Docs]({% link _docs/config/env.md %}).

## Dockerfile

The `Dockerfile` is a simple starter example that just runs nginx

Dockerfile:

    # Simple example starter
    FROM nginx
    EXPOSE 80
    CMD ["nginx", "-g", "daemon off;"]

Note: If your project already has a Dockerfile, kubes will use that instead of generating a starter one.
