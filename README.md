# Kubes

[![Gem Version](https://badge.fury.io/rb/kubes.png)](http://badge.fury.io/rb/kubes)

[![BoltOps Badge](https://img.boltops.com/boltops/badges/boltops-badge.png)](https://www.boltops.com)

Kubernetes Deployment Tool: build docker image, compile Kubernetes YAML files, and apply them.

Kubes will:

1. Build the docker image and push it to repo
2. Compile Kubernetes YAML files from DSL, injecting the build image
3. Deploy via kubectl apply on the compiled Kubernetes YAML files

Features:

* Automation: Builds the Docker image and updates the compiled YAML files
* Syntactic Sugar: Use an optional DSL or ERB/YAML to write your Kubneretes YAML files.
* Layering: Use the same Kubernetes YAML to build multiple environments like dev and prod.

## Usage

    kubes apply APP [RESOURCE]        # Apply the Kubenetes YAML files without changing them
    kubes compile                     # Compile Kubenetes YAML files from DSL
    kubes delete APP [RESOURCE]       # Delete Kubenetes resources within the app folder
    kubes deploy APP [RESOURCE]       # Deploy to Kubenetes: docker build/push, kubes compile...
    kubes docker build                # Build docker image.
    kubes init --app=APP --repo=REPO  # Init project

## Init

The `init` command generates starter `.kubes` [structure](docs/structure.md). Refer to the structure docs for a complete explanation. Here's the resources part of the structure.

    .kubes
    └── resources
        └── demo-web
            ├── deployment.rb
            └── service.rb

Use YAML:

    kubes init --app demo-web --image "user/demo" --type yaml

Use DSL:

    kubes init --app demo-web --image "user/demo" --type dsl

Different repos:

    kubes init --app demo-web --image "user/demo" # DockerHub
    kubes init --app demo-web --image "112233445566.dkr.ecr.us-west-2.amazonaws.com/demo/sinatra" # ECR
    kubes init --app demo-web --image "gcr.io/#{ENV['GOOGLE_PROJECT']}/demo-web" # GCR

## Deploy

Edit the files in the `.kubes/resources/demo-web` folder to your needs.

Deploy all resources in .kubes/resources/demo-web

    kubes deploy demo-web

Deploy specific resource, like .kubes/resources/demo-web/deployment.rb

    kubes deploy demo-web deployment
    kubes deploy demo-web service

## DSL or YAML

You can define your Kubernetes resources in a [DSL](docs/dsl.md) or [YAML](docs/yaml.md)

## Layering Support

## Installation

Install with:

    gem install kubes

