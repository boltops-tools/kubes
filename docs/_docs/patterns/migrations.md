---
title: Database Migrations
nav_text: Database Migrations
categories: patterns
---

A common task is to run database migrations. You can use Kubes hooks to achieve this as part of the `kubes deploy` process.

1. Create Migrate Job YAML
2. Set up Kubes Hooks

## 1. Create Migrate Job YAML

First, let's create the migrate job YAML. Here's a starter example:

.kubes/resources/migrate/job.yaml

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: migrate
spec:
  template:
    spec:
      containers:
      - name: migrate
        image: <%= docker_image %>
        command: ["bin/job/migrate.sh"]
      restartPolicy: Never
  backoffLimit: 4
```

The Kubernetes job calls a `job/migrate.sh` script. Something like this:

bin/job/migrate.sh

    #!/bin/bash
    rails db:migrate

## 2. Set up Kubes Hooks

Set up the [kubes hooks]({% link _docs/config/hooks/kubectl.md %}) to help the migrate job run properly.

.kubes/config/hooks/kubectl.rb

```ruby
before("apply",
  on: "migrate/job",
  execute: "bin/hooks/migrate/delete.sh",
  exit_on_fail: false,
)

after("apply",
  on: "migrate/job",
  execute: "bin/hooks/migrate/wait.sh",
)
```

Here's what the `bin/hook/migrate` scripts could look like:

bin/hooks/migrate/delete.sh

    #!/bin/bash
    kubectl delete job/migrate

bin/hooks/migrate/wait.sh

    #!/bin/bash
    kubectl wait --for=condition=Complete job/migrate --timeout=300s

The `migrate/delete.sh` script first cleans up old migrate jobs that may have been previously created.

The `migrate/wait.sh` script waits until the migration job finishes before continuing. Note, the default timeout is 30s, which may not be long enough for your migrations to finish, so we set it to 300s.  The `kubectl wait` only returns if the migrate job finishes successfully. If the job fails after it exhausts all its retries, default 6, then you'll see an error like this:

    + kubectl wait --for=condition=Complete job/migrate --timeout=30s
    error: timed out waiting for the condition on jobs/migrate
    ERROR: running bin/hooks/migrate.sh

There is also an [migration-example](https://github.com/boltops-tools/kubes-examples/tree/master/yaml/migration-example) repo with a smarter version of the wait script.

## Example Deploy

Once that is set up, a `kubes deploy` will automatically run migrations. Here's an example deploy:

    $ kubes deploy
    => kubectl apply -f .kubes/output/shared/namespace.yaml
    => bin/hooks/migrate/delete.sh
    job.batch "migrate" deleted
    => kubectl apply -f .kubes/output/migrate/job.yaml
    job.batch/migrate created
    Running hook: after apply on: migrate/job
    => bin/hooks/migrate/wait.sh
    Sun Oct 11 03:22:35 UTC 2020
    Migration complete
    => kubectl apply -f .kubes/output/web/service.yaml
    service/web unchanged
    => kubectl apply -f .kubes/output/web/deployment.yaml
    deployment.apps/web configured
    $

## To Couple or Not to Couple?

While some companies prefer running the migration step as a part of the app deploy, some prefer to separate it out as a discrete step. Usually, the separate step is still called as part of a pipeline.

In practice, the decision usually comes down to:

* The size of your database. If your database is large and the migrations take a long time to run. It makes sense to separate it out.
* The risk tolerance of database migration operations. If it's quite risky to run DB migrations, you may want to separate it as discrete step so a human can review it.

For small apps and databases, it's often pragmatic to just run everything in a single step for simplicity.

## Migration as Separate Step

If you would like it to run it as a discrete step, remove the hook in `.kubes/config/hooks/kubectl.rb`, and run it as a separate script like so:

bin/run/migrate.sh

    #!/bin/bash
    kubes compile
    bin/hooks/migrate/delete.sh
    bin/job/migrate.sh
    bin/hooks/migrate/wait.sh
