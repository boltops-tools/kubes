---
title: "Debugging Layering"
category: layering
order: 9
---

Kube's Layering abilities are so powerful that they can be difficult to debug when overly used.  It is recommend you chose only a few layers that make sense for your goals and stick to them. Essentially, limit the rope length. Here are also some debugging tips.

## Enable Logging

You can debug layers by turning a config to show the **found** layers. Currently, only variables layering is shown.

.kubes/config.rb

```ruby
Kubes.configure do |config|
  config.layering.show = true
end
```

This will show the **found** layers.

        $ kubes compile
        Compiling .kubes/resources/shared/namespace.yaml
            .kubes/variables/base.rb
            .kubes/variables/dev.rb
        Compiling .kubes/resources/web/deployment.yaml
            .kubes/variables/base.rb
            .kubes/variables/dev.rb
        Compiling .kubes/resources/web/service.yaml
            .kubes/variables/base.rb
            .kubes/variables/dev.rb

## All Considered Layers

If you want to also see all the considered layers use `KUBES_LAYERING_SHOW_ALL=1`. Note, this will show a lot of layers. Kubes considers many layers and for files `base/all.yml` also perform layering and results are ultimately merged together. Here's an example snippet of the output.

    $ export KUBES_LAYERING_SHOW_ALL=1
    Compiling .kubes/resources/web/deployment.yaml
    Rendering .kubes/resources/web/deployment.yaml
        .kubes/variables/base.rb
        .kubes/variables/dev.rb
        .kubes/variables/base/all.rb
        .kubes/variables/base/all/dev.rb
        .kubes/variables/base/deployment.rb
        .kubes/variables/base/deployment/base.rb
        .kubes/variables/base/deployment/dev.rb
        .kubes/variables/web/deployment.rb
        .kubes/variables/web/deployment/base.rb
        .kubes/variables/web/deployment/dev.rb
    Rendering .kubes/resources/base/all.yaml
        .kubes/variables/base.rb
        .kubes/variables/dev.rb
        .kubes/variables/base/all.rb
        .kubes/variables/base/all/dev.rb
        .kubes/variables/base/deployment.rb
        .kubes/variables/base/deployment/base.rb
        .kubes/variables/base/deployment/dev.rb
        .kubes/variables/web/deployment.rb
        .kubes/variables/web/deployment/base.rb
        .kubes/variables/web/deployment/dev.rb
    ...