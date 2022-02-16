---
title: Config Map Files
nav_text: Config Map Files
---

The `config_map_files` helper allows you to add config map data from a list of files. The files support layerying.

## Example

Here's how to use it.

.kubes/resources/shared/config_map.yaml

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo
  labels:
    app: demo
data:
<%= config_map_files %>
```

You can conveniently set multiple configmap values in files like so:

.kubes/resources/shared/config_map/base.txt

    KEY1=cmvalue1
    KEY2=cmvalue2

.kubes/resources/shared/config_map/dev.txt

    KEY2=cmvalue2-dev-override
    KEY3=cmvalue3

The resulting generated ConfigMap will be:

```yaml
---
metadata:
  namespace: demo-dev
  labels:
    app: demo
  name: demo-928146dd24
apiVersion: v1
kind: ConfigMap
data:
  KEY1: cmvalue1
  KEY2: cmvalue2-dev-override
  KEY3: cmvalue3
```

## Layering Details

Layering for Config Map Files and also supports app-scoped layers.

Name | Example
--- | ---
configmap root | .kubes/resources/shared/config_map/{base,dev}.txt
configmap app file | .kubes/resources/shared/config_map/app1.txt
configmap app folder | .kubes/resources/shared/config_map/app1/{base,dev}.txt

So if `KUBES_APP=app1`, then the app-scoped layer is also used. This handles the [Central Deployer Pattern]({% link _docs/patterns/central-deployer.md %}).
