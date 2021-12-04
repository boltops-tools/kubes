---
title: Docker Hooks
nav_text: Docker
categories: hooks
---

{% include config/hooks/generator.md type="docker" %}

Here are some examples of running custom hooks before and after the docker commands.

## Build Hooks

.kubes/config/hooks/docker.rb

```ruby
before("build",
  execute: "echo 'docker build before hook'",
)

after("build",
  execute: "echo 'docker build after hook'",
)
```

Results in:

    $ kubes docker build
    Running docker before build hook.
    => echo 'docker build before hook'
    docker build before hook
    => docker build -t gcr.io/tung-275700/demo:kubes-2020-10-10T20-06-28-2e80bf4 -f Dockerfile .
    Running docker after build hook.
    => echo 'docker build after hook'
    docker build after hook
    $

## Push Hooks

```ruby
before("push",
  execute: "echo 'docker push before hook'",
)

after("push",
  execute: "echo 'docker push after hook'",
)
```

Results in:

    $ kubes docker push
    Running docker before push hook.
    => echo 'docker push before hook'
    docker push before hook
    => docker push gcr.io/tung-275700/demo:kubes-2020-10-10T20-06-28-2e80bf4
    Running docker after push hook.
    => echo 'docker push after hook'
    docker push after hook
    $

## exit_on_fail option

By default, if the hook commands fail, then kubes will exit with the original hook error code.  You can change this behavior with the `exit_on_fail` option.

```ruby
before("build"
  execute: "/command/will/fail/but/will/continue",
  exit_on_fail: false,
)
```

{% include config/hooks/options.md command="docker" %}
