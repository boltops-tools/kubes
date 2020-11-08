### Kubes Layering

To deploy and create multiple environments like dev and prod with the same YAML, we use a different KUBES_ENV setting:

    KUBES_ENV=dev  kubes deploy
    KUBES_ENV=prod kubes deploy

The layering is achieved thanks to the conventional project structure. You don't have to do any extra work, you just create pre-process base layer files or post-process environment specific layer files.

* [Kubes Layering Docs]({% link _docs/layering.md %})
