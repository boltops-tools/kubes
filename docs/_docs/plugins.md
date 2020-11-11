---
title: Kubes Plugins
---

Kubes makes it easier to work with Kubernetes by automating the deployment workflow. Many of the conveniences it adds is done with plugins. For example, `aws_secret`, `aws_ssm`, `google_secret` are implemented with Cloud Provider specific Kubes plugins.

## Baseline Plugins

The baseline plugins that currently ship with Kubes are:

* [kubes_aws]({% link _docs/plugins/aws.md %})
* [kubes_google]({% link _docs/plugins/google.md %})
