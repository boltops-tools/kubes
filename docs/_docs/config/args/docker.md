---
title: Docker Args
nav_text: Docker
categories: args
---

Here are some examples of customizing the docker args.

.kubes/config/args/docker.rb

```ruby
command("build",
  args: ["--quiet"],
)

command("push",
  args: ["--disable-content-trust"],
)
```
