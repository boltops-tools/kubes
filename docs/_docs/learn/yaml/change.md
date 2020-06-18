---
title: Change Project
---

Let's make a simple change. We'll adjust the number of replicas to 3.  We do this in `deployment/dev.yaml`.

.kubes/resources/demo-web/deployment/dev.yaml

```yaml
---
spec:
  replicas: 3 # <= CHANGED
```

This demonstrates Kubes [Layering support]({% link _docs/layering.md %}). We can make changes to only the `KUBES_DEV` environment.

Next, we'll deploy this update.
