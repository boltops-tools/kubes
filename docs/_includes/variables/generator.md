## Generator

To help you get started quickly, you can generate starter variable code.

    $ kubes new variable
          create  .kubes/variables/dev.rb

.kubes/variables/dev.rb

```ruby
@example = "dev-value"
```

To create the prod variables, set `KUBES_ENV=prod`.

    $ KUBES_ENV=prod kubes new variable
          create  .kubes/variables/prod.rb

.kubes/variables/prod.rb

```ruby
@example = "prod-value"
```
