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
* The Google helpers are provided by the [boltops-tools/kubes_google](https://github.com/boltops-tools/kubes_google) library.

## Authentication

Most of the Google helpers use the SDK to call the Google Cloud API. As such, it needs to be authenticated.  You can do this by setting the `GOOGLE_APPLICATION_CREDENTIALS` environment variable point to the path with a service account credentials file. IE:

.bash_profile

    export GOOGLE_APPLICATION_CREDENTIALS=~/.gcp/service-account.json

If you would like to use a user IAM credentials instead of a service account. You can also run use [application-default login](https://cloud.google.com/sdk/gcloud/reference/auth/application-default/login). Example:

    gcloud auth application-default login

This generates a to use for Application Default Credentials at `.config/gcloud/application_default_credentials.json`. Note, make sure that `GOOGLE_APPLICATION_CREDENTIALS` is not set or else the `application_default_credentials.json` will not be used.  Also, will print a warning to use a service account instead. You can suppress that warning with this:

.bash_profile

    export GOOGLE_AUTH_SUPPRESS_CREDENTIALS_WARNINGS=1
