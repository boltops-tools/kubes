* Automation: [Builds the Docker image]({% link _docs/config/docker.md %}) and updates the compiled YAML files
* Syntactic Sugar: Use an [ERB/YAML]({% link _docs/yaml.md %}) or a [DSL]({% link _docs/dsl.md %}) to write your Kubernetes YAML files. You can use a mix of DSL and YAML definitions in the `.kubes/resources` folder.
* Layering: Use the same Kubernetes YAML to build multiple environments like dev and prod with [layering]({% link _docs/layering.md %}).
* Secrets: Use helpers like [aws_secret]({% link _docs/helpers/aws/secrets.md %}), [aws_ssm]({% link _docs/helpers/aws/ssm.md %}), and [google_secret]({% link _docs/helpers/google/secrets.md %}) to build Kubernetes secrets.yaml from secret providers designed for it.
* Generators: Kubes ships with a few generators to help you get building with Kubernetes quickly. See: [Generator Docs]({% link _docs/generators.md %}).
* CLI Customizations: You can customize the [cli args]({% link _docs/config/args/kubectl.md %}).
* Hooks: You can also run [hooks]({% link _docs/config/hooks.md %}) before and after [kubes]({% link _docs/config/hooks/kubes.md %}) and [kubectl]({% link _docs/config/hooks/kubectl.md %}) commands.
* Automated Suffix Hashes: Automatically appends a suffix hash to ConfigMap and Secret resources. More details in [ConfigMap]({% link _docs/dsl/resources/config_map.md %}) and [Secret]({% link _docs/dsl/resources/secret.md %}) docs.
* Kustomize Support: If you're a kustomization user, you can use it with Kubes. More details in [Kustomize Support Docs]({% link _docs/misc/kustomize.md %}).
* Auto Context Switching: Map dev to a specific kubectl context and prod to another kubectl context and Kubes can switch them automatically so you won't have to remember. More details in [Auto Context Docs]({% link _docs/misc/auto-context.md %}).
* Ordering: Kubes run kubectl apply to create resources in the [correct order]({% link _docs/intro/ordering.md %}). For deleting, it kubes will run `kubectl delete` in the correct reverse order. The order is also [customizable]({% link _docs/intro/ordering/custom.md %}).
