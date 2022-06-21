---
title: New Project
---

If you already a project with an existing Dockerfile, you can use that. If you do not, kubes generates a starter Dockerfile that runs nginx. For this tutorial, we'll start with an empty folder.

    mkdir demo
    cd demo

{% include learn/repos.md %}

Let's initialize a starter kubes project. This is similar to a `git init`.

    $ kubes init --app demo --repo $REPO
          create  Dockerfile
          create  .kubes/config.rb
          create  .kubes/config/env/dev.rb
          create  .kubes/config/env/prod.rb
          create  .kubes/resources/base/all.yaml
          create  .kubes/resources/base/deployment.yaml
          create  .kubes/resources/shared/namespace.yaml
          create  .kubes/resources/web/deployment.yaml
          create  .kubes/resources/web/deployment/dev.yaml
          create  .kubes/resources/web/deployment/prod.yaml
          create  .kubes/resources/web/service.yaml
    Initialized .kubes folder
    Updated .gitignore
    $

To learn more about the generated structure, here are the [Structure Docs]({% link _docs/intro/structure.md %}).

Let's explore some of the generated files.

{% include learn/review.md %}

Next, we'll review the resources.
