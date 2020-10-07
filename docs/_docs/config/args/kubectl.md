---
title: Kubectl Args
nav_text: Kubectl
categories: args
---

Here are some examples of customizing the kubectl args.

.kubes/config/kubectl/args.rb

```ruby
command("apply",
  args: ["--validate=true"],
)

command("delete",
  args: ["--grace-period=-1"],
)
```
