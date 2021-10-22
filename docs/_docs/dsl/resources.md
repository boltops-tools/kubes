---
title: Resources
---

Here's a list of the resources supported by the Kubes DSL.

{% assign docs = site.docs | where: "categories","dsl" %}
{% for doc in docs -%}
* [{{ doc.title }}]({{ doc.url }})
{% endfor %}

For resources, that are not supported, you can use the [Generic resource]({% link _docs/dsl/resources/generic.md %}) or use [YAML]({% link _docs/yaml.md %}) instead. You can use a mix of DSL and YAML definitions in the `.kubes/resources` folder.
