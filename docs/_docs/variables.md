---
title: Variables
---

You can set variables to be made available to the templates. Generally, it is recommended to use Basic layering.

{% assign docs = site.docs | where: "categories","variables" %}
{% for doc in docs -%}
* [{{ doc.title }}]({{ doc.url }})
{% endfor %}

## Generator

To help you get started quickly, you can generate starter variable code.

    $ kubes new variable
          create  .kubes/variables/dev.rb

.kubes/variables/dev.rb

```ruby
@example = "dev-value"
```
