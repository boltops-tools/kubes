---
title: What is Kubes?
---

{% include reference.md %}

<div class="video-box"><div class="video-container"><iframe src="https://www.youtube.com/embed/M4zHL0mfKNU" frameborder="0" allowfullscreen=""></iframe></div></div>

## Features:

* Automation: [Builds the Docker image]({% link _docs/config/docker.md %}) and updates the compiled YAML files
* Syntactic Sugar: Use an [ERB/YAML]({% link _docs/yaml.md %}) or a [DSL]({% link _docs/dsl.md %}) to write your Kubernetes YAML files. You can use a mix of DSL and YAML definitions in the `.kubes/resources` folder.
* Layering: Use the same Kubernetes YAML to build multiple environments like dev and prod with [layering]({% link _docs/layering.md %}).
* CLI Customizations: You can customize the [cli args]({% link _docs/config/kubectl/args.md %}). You can also run [hooks]({% link _docs/config/kubectl/hooks.md %}) before and after kubectl commands.
* Automated Suffix Hashes: Automatically appends a suffix hash to ConfigMap and Secret resources. More details in [ConfigMap]({% link _docs/dsl/resources/config_map.md %}) and [Secret]({% link _docs/dsl/resources/secret.md %}) docs.
* Kustomize Support: If you’re a kustomization user, you can use it with Kubes. More details in [Kustomize Support Docs]({% link _docs/misc/kustomize.md %}).
* Auto Context Switching: Map dev to a specific kubectl context and prod to another kubectl context and Kubes can switch them automatically so you won't have to remember. More details in [Auto Context Docs]({% link _docs/misc/auto-context.md %}).
* Ordering: Kubes run kubectl apply to create resources in the [correct order]({% link _docs/intro/ordering.md %}). For deleting, it kubes will run `kubectl delete` in the correct reverse order. The order is also [customizable]({% link _docs/intro/ordering/custom.md %}).
