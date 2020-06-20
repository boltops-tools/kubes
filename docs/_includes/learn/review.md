## Config

The `config.rb` is where you can configure Kubes settings.

```ruby
Kubes.configure do |config|
  config.repo = "112233445566.dkr.ecr.us-west-2.amazonaws.com/demo"
  config.logger.level = "info"
  # auto-switching
  # config.kubectl.context = "dev-services"
end
```

This is where the `--repo` from `kubes init` got saved.  The other options are covered in the [Env Config Docs]({% link _docs/config/env.md %}).

## Dockerfie

The `Dockerfile` is a simple starter example that just runs nginx.

Dockerfile:

    # Simple example starter
    FROM nginx
    EXPOSE 80
    CMD ["nginx", "-g", "daemon off;"]
