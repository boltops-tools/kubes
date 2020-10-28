---
title: AWS Helpers
---

List of AWS helpers:

{% assign docs = site.docs | where: "categories","helpers-aws" %}
{% for doc in docs -%}
  * [{{ doc.nav_text }}]({{ doc.url }})
{% endfor %}

## Notes

* By default, `KubeGoogle.logger = Kubes.logger`. This means, you can set `logger.level = "debug"` in `.kubes/config.rb` to see more details.
* The AWS helpers are provided by the [boltops-tools/kubes_aws](https://github.com/boltops-tools/kubes_aws) library.
