---
title: Kubes vs Custom Solutions
nav_text: Custom Solutions
categories: vs
---

Kubernetes provide a great platform to run and manage Docker containers. The `kubectl` command how you usually interact with a Kubernetes cluster.  It does its job well and is quite a powerful tool.

{% include vs/article.md %}

## Kubernetes Questions

With Kubernetes, you usually use `kubectl` commands to deploy Docker images and run them on a Kubernetes cluster. As you get your Kubernetes applications production-ready, you'll have to answer many questions:

* How do you create multiple environments like dev and prod with the same code and not duplicate the YAML?
* How you handle creating service accounts and managing cloud permissions like AWS IAM, Google Service Accounts, etc?
* How will we build the Docker image and update Docker image?
* How do you deploy updated Kubernetes YAML settings in a controlled manner?

## Kubectl with Simple Wrappers

Most folks start off with `kubectl` commands to create their Kubernetes resources. It's simple. It's also important to learn how to use `kubectl` commands to establish fundamentals. Eventually, you grow tired of typing the same commands repeatedly, though. So you write a wrapper bash script. Example:

kubectl-wrapper.sh

    kubectl apply -f service.yaml
    kubectl apply -f deployment.yaml

Bash shines for simple scripts and light glue, but it can quickly get messy as the script takes on more things to do.

## Multiple Envs Duplication

One way to create different env like dev and prod is to copy their YAML files. Here's a naive example structure:

    ├── dev
    │   ├── deployment.yaml
    │   └── service.yaml
    └── prod
        ├── deployment.yaml
        └── service.yaml

We then write a wrapper script that selects the folder:

kubectl-wrapper.sh

    KUBE_ENV=${1:-dev}
    kubectl apply -f $KUBE_ENV/service.yaml
    kubectl apply -f $KUBE_ENV/deployment.yaml

We've duplicated `service.yaml` and `deployment.yaml`, though. Instead, it'll be nice if we use the same YAML and create a different env like dev and prod with it. Things like `envsubst` to replace variables from the same "template" YAML files can help. As requirements increases, the simple bash glue scripts end up getting messy.

## PreBuilt Docker Image

Additionally, the Docker image is expected to be prebuilt. Because you must first build the Docker image, folks will usually write bash script that perform these additional steps and then glue things together.

## Kubernetes Resources Galore

Kubernetes has a large service area, and there are so many resource Kinds that we can create that it's difficult for a simple wrapper script to handle enough control for your needs.

## Kubes Makes It Easier

Kubes is a Kubernetes Deployment Tool that automates the following:

1. It builds the docker image
2. Creates the Kubernetes YAML
3. Runs kubectl apply

Kubes works transparently and straightforwardly. The deploy command simply do all 3 steps: build, compile, and apply.

    kubes deploy

### Layering: Multiple Environments like dev and prod

To deploy and create multiple environments like dev and prod with the same YAML, we use a different KUBES_ENV setting:

    KUBES_ENV=dev kubes deploy
    KUBES_ENV=prod kubes deploy

The same code is used to create different environments. Kubes achieves this with a feature called Layering. The concept is similar to Kustomize overlays. Here's the general layering processing order that Kubes takes.

* [Layering Docs]({% link _docs/layering.md %})

## Hooks

Kubes support a variety of hooks run scripts at any part of the `kubectl` commands. This allows you customize and add app-specific logic needed. Example:

.kubes/config/hooks/kubectl.rb

```ruby
before("apply",
  on: "web/deployment",
  execute: "echo 'before apply hook test'",
)

after("delete",
  on: "web/deployment",
  execute: "echo 'after delete hook test'",
)
```

There are also [cloud helpers]({% link _docs/helpers.md %}) that will handle things like Secrets and IAM Account creation.

* [Kubes Kubectl Hooks Docs]({% link _docs/config/hooks/kubectl.md %})

## Summary

Many companies roll their own custom solutions. Chances are that the `kubectl` wrapper scripts eventually grow into messy glue. Every time you go to another company, you must relearn and figure out the home-grown solution's particularities. Even within companies, going from team to team, there may be different scripts that are their own unique beasts. It's a science project.

Kubes provides a tool that streamlines the `kubectl` deployment already. Kubes also works in a transparent and straightforward manner. You know what's going on. It's also extendable and customizable. You can add business logic that you wish.  Kubes provides convenient tooling and helps you get things done quickly.
