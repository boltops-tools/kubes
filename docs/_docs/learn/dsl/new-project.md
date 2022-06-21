---
title: New Project
---

If you already a project with an existing Dockerfile, you can use that. If you do not, kubes generates a starter Dockerfile that runs nginx. For this tutorial, we'll start with an empty folder.

    mkdir demo
    cd demo

{% include learn/repos.md %}

Let's initialize a starter kubes project. This is similar to a `git init`.

    $ kubes init --app demo --repo $REPO --type dsl
          create  .kubes/config.rb
          create  .kubes/config/env/dev.rb
          create  .kubes/config/env/prod.rb
          create  .kubes/resources/base/all.rb
          create  .kubes/resources/shared/namespace.rb
          create  .kubes/resources/web/deployment.rb
          create  .kubes/resources/web/deployment/dev.rb
          create  .kubes/resources/web/deployment/prod.rb
          create  .kubes/resources/web/service.rb
    Initialized .kubes folder
    $

The `--type=dsl` option tells Kubes to generate DSL format files. To learn more about the generated structure, here are the [Structure Docs]({% link _docs/intro/structure.md %}).

Let's explore some of the generated files.

{% include learn/review.md %}

Next, we'll review the resources.
