---
title: New Project
---

If you already a project with an existing Dockerfile, you can use that. If you do not, kubes generates a starter Dockerfile that runs nginx. For this tutorial, we'll start with an empty folder.

    mkdir demo
    cd demo

For this tutorial, we'll use an ECR repo, though any repo will work.

Let's generate a starter project:

    $ REPO=$(aws ecr describe-repositories --repository-name demo | jq -r '.repositories[].repositoryUri')
    $ kubes init --app demo --repo $REPO --type dsl
          create  .kubes/config.rb
          create  .kubes/config/env/dev.rb
          create  .kubes/config/env/prod.rb
          create  .kubes/resources/base/all.rb
          create  .kubes/resources/web/deployment.rb
          create  .kubes/resources/web/deployment/dev.rb
          create  .kubes/resources/web/deployment/prod.rb
          create  .kubes/resources/web/service.rb
    Initialized .kubes folder
    $

The `--type=dsl` option tells Kubes to generate DSL format files.

To learn more about the generated structure, here are the [Structure Docs]({% link _docs/intro/structure.md %}).

Next, we'll review the files.
