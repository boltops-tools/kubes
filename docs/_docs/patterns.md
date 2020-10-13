---
title: Patterns
---

We'll cover some common deployment patterns here:

{% assign docs = site.docs | where: "categories","patterns" %}
{% for doc in docs -%}
* [{{ doc.title }}]({{ doc.url }})
{% endfor %}
