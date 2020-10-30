The exec command finds the latest pod from the deployment and runs `kubectl exec -ti POD bash` to get you into it. It spares you from having to manually find and type it.

## Examples

    kubes exec
    kubes exec sh
    kubes exec ls -l

## Multiple Deployments

If you have have multiple deployments in your `.kubes/resources` then the command will use the first deployment by default. You can specify the specfic deployment with the `--name` or `-n` option.  Examples:

    kubes exec --name web
    kubes exec -n web
    kubes exec -n clock
    kubes exec -n worker
    kubes exec -n web sh
    kubes exec -n web ls -l

## Multiple Pod Containers

If you have have multiple containers in your pod. You can specify the specfic container with the `--container` or `-c` option.  Examples:

    kubes exec --name web

## Default Exec Command

The default exec command is `sh`.  Example:

    $ kubes exec
    => kubectl exec -n demo-dev -ti web-568645f665-62j8f -- sh
    /app #

You can override the default with `KUBES_DEFAULT_EXEC`.  Example:

    $ export KUBES_DEFAULT_EXEC=bash
    $ kubes exec
    => kubectl exec -n demo-dev -ti web-568645f665-62j8f -- bash
    /app #
