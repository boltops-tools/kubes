## App-Level Specific Settings

You can override all the different settings at the app-level when KUBES_APP is set.

For app1:

    cd app1
    KUBES_APP=app1 kubes deploy

And for app2:

    cd app2
    KUBES_APP=app2 kubes deploy

## Config Env

Override `config/app.rb` with app-level settings like so:

    .kubes/config/env/app1/base.rb
    .kubes/config/env/app1/dev.rb
    .kubes/config/env/app1/prod.rb
    .kubes/config/env/app2/base.rb
    .kubes/config/env/app2/dev.rb
    .kubes/config/env/app2/prod.rb

## Variables

Override `.kubes/variables/base.rb`, `.kubes/variables/dev.rb` etc like so:

    .kubes/variables/app1/base.rb
    .kubes/variables/app1/dev.rb
    .kubes/variables/app1/prod.rb
    .kubes/variables/app2/base.rb
    .kubes/variables/app2/dev.rb
    .kubes/variables/app2/prod.rb

## Resources

Override resources like so:

    .kubes/resources/shared/config_map/app1.yaml
    .kubes/resources/shared/config_map/app2.yaml
    .kubes/resources/shared/secret/app1.yaml
    .kubes/resources/shared/secret/app2.yaml
