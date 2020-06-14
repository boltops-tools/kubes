# Kubes

[![Gem Version](https://badge.fury.io/rb/kubes.png)](http://badge.fury.io/rb/kubes)

[![BoltOps Badge](https://img.boltops.com/boltops/badges/boltops-badge.png)](https://www.boltops.com)

Kubernetes Deployment Tool: build docker image, compile Kubernetes YAML files, and apply them.

Kubes will:

1. Build the docker image and push it to repo
2. Compile Kubernetes YAML files from DSL, injecting the build image
3. Deploy via kubectl apply on the compiled Kubernetes YAML files

Features:

* Automation: [Builds the Docker image](docs/docker.md) and updates the compiled YAML files
* Syntactic Sugar: Use an optional [ERB/YAML](docs/yaml.md) or [DSL](docs/dsl.md) to write your Kubneretes YAML files. You can use a mix of DSL and YAML definitions in the `.kubes/resources` folder.
* Layering: Use the same Kubernetes YAML to build multiple environments like dev and prod with [layering](docs/layering.md).
* CLI Customizations: You can customize the [cli args](docs/kubectl.md). You can also run hooks before and after kubectl commands.

## Usage

    kubes init # creates .kubes structure
    # edit the .kubes/resources files to your needs
    kubes deploy

## How It Works

Kubes is pretty straightforward. Kubes first builds the Docker image and compiles Kubernetes YAML files. Then it merely calls `kubectl`.

In fact, you can use Kubes to build the files first, and then run `kubectl` directly. Example:

    kubes docker build
    kubes docker push
    kubes compile  # compiles the .kubes/resources files to .kubes/output

Now, use `kubectl` directly. This will apply all the files:

    kubectl apply --recursive -f .kubes/output

You can also selectively apply specific files:

    kubectl apply -f .kubes/output/demo-web/deployment.yaml
    kubectl apply -f .kubes/output/demo-web/service.yaml

You can also apply with kubes. This will compile the automatically files also.

    kubes apply

The deploy command, does all 3 steps: builds the docker image, compiles the `.kubes/resources` files, and runs kubectl apply.

    kubes deploy

## Commands

    kubes apply [APP] [RESOURCE]      # Apply the Kubenetes YAML files without changing them
    kubes compile                     # Compile Kubenetes YAML files from DSL
    kubes delete [APP] [RESOURCE]     # Delete Kubenetes resources within the app folder
    kubes deploy [APP] [RESOURCE]     # Deploy to Kubenetes: docker build/push, kubes compile...
    kubes docker build                # Build docker image.
    kubes init --app=APP --repo=REPO  # Init project

## Init

The `init` command generates starter `.kubes` [structure](docs/structure.md). Refer to the structure docs for a complete explanation. Here's the resources part of the structure.

    .kubes
    └── resources
        └── demo-web
            ├── deployment.rb
            └── service.rb

Use YAML with templating:

    kubes init --app demo-web --image "user/demo" --type yaml

Use DSL:

    kubes init --app demo-web --image "user/demo" --type dsl

Different repos:

    kubes init --app demo-web --image "user/demo" # DockerHub
    kubes init --app demo-web --image "112233445566.dkr.ecr.us-west-2.amazonaws.com/demo/sinatra" # ECR
    kubes init --app demo-web --image "gcr.io/#{ENV['GOOGLE_PROJECT']}/demo-web" # GCR

## Deploy

Edit the files in the `.kubes/resources/demo-web` folder to your needs.

Deploy all app resources in .kubes/resources/demo-web

    kubes deploy demo-web

Deploy specific resource, like .kubes/resources/demo-web/deployment.rb

    kubes deploy demo-web deployment
    kubes deploy demo-web service

## Deploy: Web, Worker, Clock Pattern

A common pattern is to use the same app code for different purposes like clock, worker, and web processes.

    .kubes
    └── resources
        ├── demo-clock
        │   └── deployment.rb
        ├── demo-worker
        │   └── deployment.rb
        └── demo-web
            ├── deployment.rb
            └── service.rb

You can deploy them all at once with:

    kubes deploy

## DSL or YAML

You can define your Kubernetes resources in a [DSL](docs/dsl.md) or [YAML](docs/yaml.md)

## Layering Support

Kubes supports layering files together so you can use the same Kubernetes files to build multiple environments like dev and prod.

See [Layering Docs](docs/layering.md).

## Installation

Install with:

    gem install kubes
