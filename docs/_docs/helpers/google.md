---
title: Google Helpers
---

List of Google helpers:

{% assign docs = site.docs | where: "categories","helpers-aws" %}
{% for doc in docs -%}
  * [{{ doc.nav_text }}]({{ doc.url }})
{% endfor %}

## Notes

* By default, `KubeGoogle.logger = Kubes.logger`. This means, you can set `logger.level = "debug"` in `.kubes/config.rb` to see more details.
* The `gcloud` cli is used to create IAM roles. So `gcloud` is required.
* Note: Would like to use the google sdk, but it wasn't obvious how to do so. PRs are welcomed.

