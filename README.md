<div align="center">
  <a href="https://kubes.guru"><img src="https://img.boltops.com/boltops/logos/kubes-black-v1.png" /></a>
</div>

# Kubes

[![Gem Version](https://badge.fury.io/rb/kubes.png)](http://badge.fury.io/rb/kubes)

[![BoltOps Badge](https://img.boltops.com/boltops/badges/boltops-badge.png)](https://www.boltops.com)

Kubernetes Deployment Tool: build docker image, compile Kubernetes YAML files, and apply them.

Please **watch/star** this repo to help grow and support the project.

Official Docs Site: [kubes.guru](https://kubes.guru)

Kubes will:

1. Build the docker image and push it to repo
2. Compile Kubernetes YAML files from YAML/ERB or a DSL and adjusts the Docker build image
3. Deploy via kubectl apply on the compiled Kubernetes YAML files

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

Now, use `kubectl` directly in the proper order:

    kubectl apply -f .kubes/output/shared/namespace.yaml
    kubectl apply -f .kubes/output/web/service.yaml
    kubectl apply -f .kubes/output/web/deployment.yaml

You can also apply with kubes. This will compile the automatically files also.

    kubes apply

The deploy command, does all 3 steps: builds the docker image, compiles the `.kubes/resources` files, and runs kubectl apply.

    kubes deploy

## Multiple Enviroments

You can easily create multiple environments with the same YAML configs. Example:

    KUBES_ENV=dev  kubes deploy
    KUBES_ENV=prod kubes deploy

See: [Multiple Enviroments Pattern](https://kubes.guru/docs/patterns/multiple-envs/)

## Generators: Stop Writing Boilerplate

Your time is precious. Why are we copying and pasting boilerplate structure in this day and age?

Kubes provides generators to help you get going right away.

Resources examples:

    $ kubes new resource secret
          create  .kubes/resources/shared/secret.yaml
    $ kubes new resource service_account
          create  .kubes/resources/shared/service_account.yaml

Kubes components examples:

    $ kubes new helper
          create  .kubes/helpers/custom_helper.rb
    $ kubes new variable
          create  .kubes/variables/dev.rb
    $

## Features

* Automation: [Builds the Docker image](https://kubes.guru/docs/config/docker/) and updates the compiled YAML files
* Syntactic Sugar: Use an [ERB/YAML](https://kubes.guru/docs/yaml/) or a [DSL](https://kubes.guru/docs/dsl/) to write your Kubernetes YAML files. You can use a mix of DSL and YAML definitions in the `.kubes/resources` folder.
* Layering: Use the same Kubernetes YAML to build multiple environments like dev and prod with [layering](https://kubes.guru/docs/layering/).
* Secrets: Use helpers like [aws_secret](https://kubes.guru/docs/helpers/aws/secrets/), [aws_ssm](https://kubes.guru/docs/helpers/aws/ssm/), and [google_secret](https://kubes.guru/docs/helpers/google/secrets/) to build Kubernetes secrets.yaml from secret providers designed for it.
* Generators: Kubes ships with a few generators to help you get building with Kubernetes quickly. See: [Generator Docs](https://kubes.guru/docs/generators/).
* CLI Customizations: You can customize the [cli args](https://kubes.guru/docs/config/args/kubectl/).
* Hooks: You can also run [hooks](https://kubes.guru/docs/config/hooks/) before and after [kubes](https://kubes.guru/docs/config/hooks/kubes/) and [kubectl](https://kubes.guru/docs/config/hooks/kubectl/) commands.
* Automated Suffix Hashes: Automatically appends a suffix hash to ConfigMap and Secret resources. More details in [ConfigMap](https://kubes.guru/docs/dsl/resources/config_map/) and [Secret](https://kubes.guru/docs/dsl/resources/secret/) docs.
* Kustomize Support: If you're a kustomization user, you can use it with Kubes. More details in [Kustomize Support Docs](https://kubes.guru/docs/misc/kustomize/).
* Auto Context Switching: Map dev to a specific kubectl context and prod to another kubectl context and Kubes can switch them automatically so you won't have to remember. More details in [Auto Context Docs](https://kubes.guru/docs/misc/auto-context/).
* Ordering: Kubes run kubectl apply to create resources in the [correct order](https://kubes.guru/docs/intro/ordering/). For deleting, it kubes will run `kubectl delete` in the correct reverse order. The order is also [customizable](https://kubes.guru/docs/intro/ordering/custom/).

## Installation

Install with:

    gem install kubes

## Comparison

Here are some useful comparisons to help you compare Kubes vs other tools in the ecosystem:

* Blog Post: [Kustomize vs Helm vs Kubes: Kubernetes Deploy Tools](https://blog.boltops.com/2020/11/05/kustomize-vs-helm-vs-kubes-kubernetes-deploy-tools)
* [Kubes vs Custom Solution](https://kubes.guru/docs/vs/custom/)
* [Kubes vs Helm](https://kubes.guru/docs/vs/helm/)
* [Kubes vs Kustomize](https://kubes.guru/docs/vs/kustomize/)

For more info: [kubes.guru](https://kubes.guru)
