---
title: Layering
---

Kubes supports layering files together so you can use the same Kubernetes files to build multiple environments like dev and prod.

{% assign docs = site.docs | where: "categories","layering" | sort: "order" %}
{% for doc in docs -%}
* [{{ doc.title }}]({{ doc.url }})
{% endfor %}
