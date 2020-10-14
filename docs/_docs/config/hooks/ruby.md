---
title: Ruby Hooks
nav_text: Ruby
categories: hooks
---

The hook `execute` option can also be provided Ruby code instead of a string.  Here's how it works:

1. When the execute option is a String: Kubes will shell out and run it as a script.
2. When the execute option is a Ruby object: Kubes will perform the `call` method on the object or class.

## Ruby Class

When the Ruby object is a class with an instance method `call`, Kubes creates a new instance of the class and runs its `call` method.  Example:

.kubes/config/hooks/kubes.rb

```ruby
class EnvExporter
  def call
    ENV['SECRET_FOO'] = Base64.strict_encode64("hi").strip
  end
end

before("compile",
  execute: EnvExporter,
)
```

Kubes will do something like this:

```ruby
EnvExporter.new.call
```

The example sets the `SECRET_FOO` environment variable. It is then available from ERB in the kubes resource files. For example:

.kubes/resources/shared/secret.yaml

```yaml
metadata:
  namespace: garden
  name: demo-secret
  labels:
    app: garden
apiVersion: v1
kind: Secret
data:
  foo: <%= ENV['SECRET_FOO'] %>
```

Note, the example above is used to explain how Ruby can be used as the execute option. For secrets, kubes supports secrets with some helpers. See: [Secrets Pattern Docs]({% link _docs/patterns/secrets.md %})

## Ruby Object

When the Ruby object, Kubes expects it to have a `call` method and will run it.  Example:

.kubes/config/hooks/kubes.rb

```ruby
before("compile",
  execute: lambda { ENV['SECRET_FOO'] = Base64.strict_encode64("hi2").strip }
)
```

Kubes will do something like this:

```ruby
@hook[:execute].call
```

## Process Context

The context in which the hook runs is worth highlighting. When the `execute` option is a String, Kubes runs the script in a **new** child process. This the script is an independent process, and whatever is done to its environment is segregated.

When the `execute` option a Ruby object, then Kubes runs the hook within the **same** process. It means the hook can affect the **same** environment. IE: Setting environment variables.
