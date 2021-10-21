---
title: Kubes Structure
---

Here's what a .kubes folder structure can look like this:

    .kubes
    ├── config
    │   ├── docker
    │   │   ├── args.rb
    │   │   └── hooks.rb
    │   ├── env
    │   │   ├── dev.rb
    │   │   └── prod.rb
    │   └── kubectl
    │       ├── args.rb
    │       └── hooks.rb
    ├── config.rb
    ├── output
    ├── resources
    │   ├── base
    │   │   └── all.yaml
    │   ├── clock
    │   │   └── deployment.yaml
    │   ├── shared
    │   │   ├── config_map.yaml
    │   │   └── secret.yaml
    │   ├── web
    │   │   ├── deployment.yaml
    │   │   └── service.yaml
    │   └── worker
    │       └── deployment.yaml
    └── state

Name | Description
--- | ---
config | The config folder can be used to configure behavior of Kubes.  The [docker]({% link _docs/config/docker.md %}) config is used to customize the docker command. The [env]({% link _docs/config/env.md %}) config is used to override `config.rb` settings on a `KUBES_ENV` basis. The [kubectl]({% link _docs/config/kubectl.md %}) config is used to customize the kubectl command.
config.rb | The main thing to configure here is the repo to push the docker image to.
output | Where kubes builds and writes the Kubernetes YAML to.
resources | Where you define your Kubernetes resources.
resources/base | The base folder is processed first and can be used to define common fields and resources. Learn more on the [Layering Docs]({% link _docs/layering.md %}).
resources/shared | The shared folder is where you can put shared resources. This folder gets applied first. More info: [Ordering]({% link _docs/intro/ordering.md %}).
state | Temporary state info that stores the built Docker image name.
