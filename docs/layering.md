# Layering

Kubes supports layering files together so you can use the same Kubernetes files to build multiple environments like dev and prod.

## Resources

The `.kubes/resources` folder is where you define your app resources. For example:

    .kubes
    └── resources
      └── demo-web
          ├── deployment.yaml
          └── service.yaml

You can create a folder matching the name of the resource and provide environment specific overrides. Example:

    .kubes
    └── resources
      └── demo-web
          ├── deployment
          │ ├── dev.yaml
          │ └── prod.yaml
          ├── deployment.yaml
          └── service.yaml
            ├── dev.yaml
            └── prod.yaml

Layering is supported for DSL `.rb` files just like YAML files.

## Config

The `.kubes/config.rb` file is where you tell kubes which repo to push the Docker image to. It looks something like this:

config.rb

```ruby
repo "112233445566.dkr.ecr.us-west-2.amazonaws.com/demo/sinatra"
```

You can override this on an environment basis:

    .kubes
    └── config
      └── env
        ├── dev.rb
        └── prod.rb

config/env/dev.rb:

```ruby
repo "11223344-DEV.dkr.ecr.us-west-2.amazonaws.com/demo/sinatra"
```

config/env/prod.rb:

```ruby
repo "1122334-PROD.dkr.ecr.us-west-2.amazonaws.com/demo/sinatra"
```
