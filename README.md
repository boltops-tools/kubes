<div align="center">
  <a href="https://kubes.guru"><img src="https://img.boltops.com/boltops/logos/kubes-black-v1.png" /></a>
</div>

# Kubes

[![Gem Version](https://badge.fury.io/rb/kubes.png)](http://badge.fury.io/rb/kubes)

[![BoltOps Badge](https://img.boltops.com/boltops/badges/boltops-badge.png)](https://www.boltops.com)

Kubernetes Deployment Tool: build docker image, compile Kubernetes YAML files, and apply them.

Official Docs Site: [kubes.guru](https://kubes.guru)

Kubes will:

1. Build the docker image and push it to repo
2. Compile Kubernetes YAML files from YAML/ERB or a DSL and adjusts the Docker build image
3. Deploy via kubectl apply on the compiled Kubernetes YAML files

Features:

* Automation: [Builds the Docker image](docs/docker.md) and updates the compiled YAML files
* Syntactic Sugar: Use an optional [ERB/YAML](docs/yaml.md) or [DSL](docs/dsl.md) to write your Kubernetes YAML files. You can use a mix of DSL and YAML definitions in the `.kubes/resources` folder.
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

    kubectl apply -f .kubes/output/web/deployment.yaml
    kubectl apply -f .kubes/output/web/service.yaml

You can also apply with kubes. This will compile the automatically files also.

    kubes apply

The deploy command, does all 3 steps: builds the docker image, compiles the `.kubes/resources` files, and runs kubectl apply.

    kubes deploy

## Installation

Install with:

    gem install kubes

For more info: [kubes.guru](https://kubes.guru)
