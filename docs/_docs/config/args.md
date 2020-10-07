---
title: Args
---

Kubes supports customizing the args passed to the `docker` and `kubectl` commands:

{% assign docs = site.docs | where: "categories","args" %}
{% for doc in docs -%}
* [{{ doc.title }}]({{ doc.url }})
{% endfor %}
