---
title: Variables
---

You can set variables to be made available to the templates. Generally, it is recommended to use Basic layering.

{% assign docs = site.docs | where: "categories","variables" %}
{% for doc in docs -%}
* [{{ doc.title }}]({{ doc.url }})
{% endfor %}

{% include variables/generator.md %}