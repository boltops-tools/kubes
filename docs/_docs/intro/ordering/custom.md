---
title: Custom Ordering
---

You can override the ordering with the `kinds` and `roles` option under the `config.kubectl.order` key. It is fully configurable. Here's an example of overriding the default ordering.

.kubes/config.rb:

```ruby
Kubes.configure do |config|
  config.kubectl.order.roles = %w[
    shared
    web
    worker
    clock
  ]
  config.kubectl.order.kinds = [
    "Namespace",
    # ...
    "Deployment",
  ]
end
```

Items not listed in the list are sorted at the end and in alphabetical order. Refer to the source [ordering.rb](https://github.com/boltops-tools/kubes/blob/master/lib/kubes/kubectl/ordering.rb) for the default ordering.
