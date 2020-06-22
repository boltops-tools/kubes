---
title: Docker Config
---

## General

Kubes builds docker images by calling the docker build commands.  Example:

    kubes docker build

To push:

    kubes docker push

## Deploy

While building the docker image as a separate step can be useful, you can just use the deploy command, and kubes will automatically build the Docker image for you. Example:

    kubes deploy web

If you want to skip the `docker build` phase of the deploy, you can run:

    kubes deploy web --no-build

Also, kubes apply another way to skip the docker build:

    kubes apply web

## Customizing Args

Here are some examples of customizing the docker args.

.kubes/config/docker/args.rb

```ruby
command("build",
  args: ["--quiet"],
)

command("push",
  args: ["--disable-content-trust"],
)
```

## Hooks

Here are some examples of running custom hooks before and after the docker commands.

.kubes/config/docker/hooks.rb

```ruby
before("build",
  execute: "echo 'docker build before hook'",
)

after("push",
  execute: "echo 'docker push before hook'",
)
```

### exit on fail

By default, if the hook commands fail, then terraspace will exit with the original hook error code.  You can change this behavior with the `exit_on_fail` option.

```ruby
before("build"
  execute: "/command/will/fail/but/will/continue",
  exit_on_fail: false,
)
```
