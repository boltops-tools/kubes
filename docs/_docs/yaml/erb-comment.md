---
title: ERB Comment Syntax PreProcessor
---

Kubes allows you build kubernetes resources by compiling down `.kubes/resources` files with ERB.  This is a powerful ability, but it can get in the way of IDE kubernetes autocompletion tools.

## Pre-Processing Before ERB

To work with IDE kubernetes autocompletion tools, kubes supports a lighter ERB comment-based syntax. It looks like this:

.kubes/resources/web/service.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web
  labels:
    name: web
#ERB if @role_label
    role: #ERB= @role_label
#ERB end
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: <%= dockerfile_port %>
  selector:
    role: web
  type: ClusterIP
```

This allows IDE kubernetes autocompletion plugins and tools to work because the `.kubes/resources/web/service.yaml` source code itself is perfectly valid YAML.

The `#ERB` comments are essentially replaced by `<% ... %>` tags before ERB processing happens. Example:

.kubes/resources/web/service.yaml.erb

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web
  labels:
    name: web
<% if @role_label %>
    role: <%= @role_label %>
<% end %>
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: <%= dockerfile_port %>
  selector:
    role: web
  type: ClusterIP
```

If you need to keep around the generated `.erb` file for debugging, use the `KUBES_KEEP_ERB` env var. Example:

    $ KUBES_KEEP_ERB=1 kubes compile
    .kubes/resources/web/service.yaml.erb  # kept around

## Multiple Line ERB Comment Syntax

The ERB Comment syntax works because kubes simply replaces each line with actual ERB. For multiple line ERB syntax:

.kubes/resources/web/service.yaml

```yaml
#ERB if Kubes.env == "dev"
#ERB   env_label = "development"
#ERB end
apiVersion: v1
kind: Service
metadata:
  name: web
  labels:
    name: web
    env: #ERB= env_label
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: <%= dockerfile_port %>
  selector:
    role: web
  type: ClusterIP
```
