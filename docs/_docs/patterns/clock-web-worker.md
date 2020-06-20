---
title: Clock Web Worker Pattern
---

A common pattern is to use the same code to run different types of processes like clock, web, worker. Kubes easily supports this pattern.

Note, often the clock process is also called a scheduler.

## Structure

Here's a structure that achieves this pattern with Kubes:

    .kubes/resources
    ├── demo-clock
    │   └── deployment.rb
    ├── demo-web
    │   ├── deployment.rb
    │   └── service.rb
    └── demo-worker
        └── deployment.rb

## Source Code

.kubes/resources/demo-clock/deployment.rb

```ruby
name "demo-clock"
namespace "default"
labels(app: name)

replicas 1
image built_image # IE: user/demo-clock:kubes-2020-06-13T19-55-16-43afc6e
command "bin/clock"
```

.kubes/resources/demo-web/deployment.rb

```ruby
name "demo-web"
namespace "default"
labels(app: name)

replicas 1
image built_image # IE: user/demo-clock:kubes-2020-06-13T19-55-16-43afc6e
```

.kubes/resources/demo-worker/deployment.rb

```ruby
name "demo-worker"
namespace "default"
labels(app: name)

replicas 2
image built_image # IE: user/demo-clock:kubes-2020-06-13T19-55-16-43afc6e
command "bin/worker"
```

## Deploy All-At-Once

To deploy all 3 process types:

    kubes deploy

## Deploy Selectively

To deploy selectively:

    kubes deploy demo-clock
    kubes deploy demo-web
    kubes deploy demo-worker
