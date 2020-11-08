---
title: Kubes vs Helm
nav_text: Helm
categories: vs
---

Though both Kubes and Helm can be used to deploy applications to Kubernetes, they work quite differently.  Kubernetes is more focused on deploying your application. Helm is more like a package manager.

{% include vs/article.md %}

## Project Structures

### Helm Project Structure

Here's an example of Helm project structure:

    ├── Chart.yaml
    ├── templates
    │   ├── _helpers.tpl
    │   ├── deployment.yaml
    │   └── service.yaml
    └── values.yaml

The Kubernetes YAML files reside in the templates folder.  The `values.yaml` contains the default configuration values for the YAML files.

{% include vs/kubes/structure.md %}

## Multiple Environments: Variables vs Layering

Both Helm and Kubes allow you to use the same code to create multiple environments. They take different approaches, though.

### Helm Variables

Helm supports creating multiple environments like dev and prod by using different variables files.  Here are example commands:

    helm install chart-dev . --namespace chart-dev --create-namespace -f values/dev.yaml
    helm install chart-prod . --namespace chart-prod --create-namespace -f values/prod.yaml

To create different environments in different namespaces with helm, you use the namespace CLI options. Helm creates the namespace outside of YAML, so it's lifecycle is not managed. The `--create-namespace` option is only necessary once.  To use different variable values, you use the `-f` option. You can specify as many variables files as you wish.

The commands can become verbose, as you have to remember to type the CLI options.

{% include vs/kubes/layering.md %}

## Templating Support

Both Helm and Kubes support templating logic.

### Helm Templating

The templating language is a mixture of the [Go template language](https://godoc.org/text/template) and the [Sprig template library](https://masterminds.github.io/sprig/). Here's an example of Helm templating.

templates/deployment.yaml

```yaml
{% raw %}apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "mychart.fullname" . }}
  labels:
    {{- include "mychart.labels" . | nindent 4 }}
spec:
{{- if not .Values.autoscaling.enabled }}
  replicas: {{ .Values.replicaCount }}
{{- end }}
  selector:
    matchLabels:
      {{- include "mychart.selectorLabels" . | nindent 6 }}
  template:
    metadata:
    {{- with .Values.podAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
    {{- end }}
      labels:
        {{- include "mychart.selectorLabels" . | nindent 8 }}
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - name: http
              containerPort: 80
              protocol: TCP{% endraw %}
```

### Kubes Templating

Kubes uses ERB Ruby for templating.  Here's an example.

.kubes/resources/web/deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
  labels:
    role: web
spec:
  replicas: 1  # overridden on a env basis
  selector:
    matchLabels:
      role: web
  template:
    metadata:
      labels:
        role: web
    spec:
      containers:
      - name: web
        image: <%= docker_image %>
```

The `docker_image` method is a built-in helper. It returns the Docker image built from your Dockerfile or a configured pre-built image. See: [Docker Image Docs]({% link _docs/intro/docker-image.md %}).

One of the reasons why the Kubes YAML template is more straightforward is because Kubes also supports layering. So logic can be moved to different layered YAML files that get merged.

## Define Custom Helpers

Both Helm and Kubes support custom user-defined helpers. We'll take a look at examples from each tool.

### Helm Helpers

With Helm, you can define custom helpers in `templates/_helpers.tpl`. Example:

templates/_helpers.tpl

```go{% raw %}
{{- define "demo.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "demo.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}{% endraw %}
```

The helper methods need to be defined in the go-lang templating language, hence the need for curly brackets.

### Kubes Helpers

With Kubes, to define template helper methods, it's just Ruby code. Example:

.kubes/helpers/my_helpers.rb

```ruby
module MyHelpers
  def database_endpoint
    case Kubes.env
    when "dev"
      "dev-db.cbuqdmc3nqvb.us-west-2.rds.amazonaws.com"
    when "prod"
      "prod-db.cbuqdmc3nqvb.us-west-2.rds.amazonaws.com"
    end
  end
end
```

The custom helper definitions are a lot more natural.

## Custom Hooks

Both Helm and Kubes support hooks. This allows you to hook into the deploy lifecycle and add your own custom business logic.

Helm supports a wide variety of hooks for the install, delete, upgrade, and rollback.  The hooks run at the helm-level.

Kubes also supports hook as the kubes-level; this is similar to the helm-level. Kubes also provide finer-grain control hooks at the kubectl-level.

Overally, Helm and Kubes hooks work quite differently. We'll take a look at **some** examples:

### Helm Hook Example

Helm hooks are Kubernetes Job resources with a special `helm.sh/hook` annotation. Example:

templates/job.yaml

```yaml
{% raw %}apiVersion: batch/v1
kind: Job
metadata:
  name: "{{ .Release.Name }}"
  annotations:
    "helm.sh/hook": post-install # This is what defines this resource as a hook.
spec:
  template:
    metadata:
      name: "{{ .Release.Name }}"
    spec:
      restartPolicy: Never
      containers:
      - name: post-install-job
        image: "alpine:3.3"
        command: ["/bin/sleep","{{ default "10" .Values.sleepyTime }}"]{% endraw %}
```

So Helm hooks are just Kubernetes jobs and run on the cluster.

### Kubes Hook Example

Kube hooks are scripts that run on the same machine that kubes is running on. Here's an example:

.kubes/config/hooks/kubectl.rb

```ruby
before("apply",
  on: "web/deployment",
  execute: "echo 'before apply hook test'",
)
```

The hook will simply run the `echo` command on the same machine as what kubes is running on.  The scope is much more fine-grain.  We can target any role and resource kind. For example:

    # hook can run here
    kubectl apply -f .kubes/output/shared/namespace.yaml
    # hook can run here
    kubectl apply -f .kubes/output/web/service.yaml
    # hook can run here
    kubectl apply -f .kubes/output/web/deployment.yaml
    # hook can run here

### Hook Differences

We showed examples of hooks with both Helm and Kubes. We already covered one of the differences:

* Code: Helm hooks are written as Kubernetes resources. Kubes hooks are written as Ruby code that can shell out to scripts or call an inline [Ruby code]({% link _docs/config/hooks/ruby.md %}).
* Context: Helm runs as a Kubernetes job. Kubes hooks run on the same machine as kubes itself.
* Fine-Grain Control: With Kubes we can target the hook at each kubectl resource. Kubes also supports the coarser-grain hooks at the kubes-level. These are like helm hooks.

For more info on hooks, check out the [Kubes Hooks Docs](https://kubes.guru/docs/config/hooks/).

## Additional Features

Helm and Kubes are quite different tools. Helm is more like a package manager. Kubes is more focused on deploying your specific application and adds additional convenient tooling.

Helm can package up your applications and then helps distribute them via a helm server. It's a full-fledge package management system.

Kubes supports the deployment workflow. It can build the docker image from your Dockerfile use it to deploy to Kubernetes. Kubes also has additional convenience CLI commands like [exec]({% link _reference/kubes-exec.md %}) and [logs]({% link _reference/kubes-logs.md %}) to work with Kubernetes containers.

## Summary

Helm and Kubes are quite different. Helm is a full-fledge package management. Kubes is a more focused on deployment. Both tools support templating logic to help keep your code DRY. Additionally, Kubes supports layering to merge YAML files together for DRYness. Kubes also helps you build your Docker images.
