---
title: What is Kubes?
---

{% include reference.md %}

## Features:

* Automation: [Builds the Docker image]({% link _docs/config/docker.md %}) and updates the compiled YAML files
* Syntactic Sugar: Use an [ERB/YAML]({% link _docs/yaml.md %}) or a [DSL]({% link _docs/dsl.md %}) to write your Kubernetes YAML files. You can use a mix of DSL and YAML definitions in the `.kubes/resources` folder.
* Layering: Use the same Kubernetes YAML to build multiple environments like dev and prod with [layering]({% link _docs/layering.md %}).
* CLI Customizations: You can customize the [cli args]({% link _docs/config/kubectl.md %}). You can also run hooks before and after kubectl commands.
