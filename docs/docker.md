# Docker

Kubes builds docker images by calling the docker build commands.  Example:

    kubes docker build

To push:

    kubes docker push

## Deploy

While build the docker image as a separate step can be useful, most of the time you can just use the deploy command and kubes will automatically build the Docker image for you. Example:

    kubes deploy demo-web

If you want to skip the `docker build` as part of the deploy, you can run:

    kubes deploy demo-web --no-build

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
