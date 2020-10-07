---
title: Skip Option
---

You can tell Kubes to skip resources to deploy. This can useful if you want to still resources with Kubes and have it compile `.kubes/output` files, but wish to deploy them outside of Kubes manually.

## Example

Here's an example with a Job.

.kubes/resources/cleanup/job.yaml:

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: cleanup
spec:
  template:
    spec:
      containers:
      - name: cleanup
        image: <%= built_image %>
        command: ["bin/cleanup.sh"]
      restartPolicy: Never
```

To skip the cleanup job, use the `config.skip` option:

```ruby
Kubes.configure do |config|
  config.skip = ["cleanup/job"]
end
```

Now when you deploy, the `cleanup/job` resource will not be deployed:

    kubes deploy # deploys everything except cleanup/job

## Deploy Outside of Kubes

Then to deploy outside of kubes.

    $ kubes compile # not necessary if already ran: kubes deploy
    Compiled  .kubes/resources files to .kubes/output
    $ kubectl apply -f .kubes/output/cleanup/job.yaml
    job.batch/cleanup created
    $ kubectl delete -f .kubes/output/cleanup/job.yaml
    job.batch "cleanup" deleted
    $

## Env Var KUBES_SKIP

You can also us ethe `KUBES_SKIP` env var. It takes list of strings separated by a space. It adds onto the `config.skip` option. Example:

    KUBES_SKIP="cleanup/job" kubes delete

This can be useful for one-off use cases.
