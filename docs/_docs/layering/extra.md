---
title: Extra Layering
category: layering
order: 8
---

Setting KUBES_EXTRA will process extra layers.

## Variables

Example

    KUBES_EXTRA=2 kubes deploy

Will process:

    .kubes/variables/dev.rb
    .kubes/variables/dev-2.rb
