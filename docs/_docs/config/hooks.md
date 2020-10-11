---
title: Hooks
---

Kubes supports a variety of hooks. They can be used to customize and finely control the kubes deploy process.

{% assign docs = site.docs | where: "categories","hooks" %}
{% for doc in docs -%}
* [{{ doc.title }}]({{ doc.url }})
{% endfor %}
