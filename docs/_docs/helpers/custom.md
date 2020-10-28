---
title: Custom Helpers
---

Kubes ships with several built-in helpers. On top of this, you can define your own custom helpers.  This allows you to define new methods and customize Kubes further.

## Example

You define custom helpers in the `.kubes/helpers` folder.

.kubes/helpers/my_helpers.rb

```ruby
module MyHelpers
  def database_endpoint
    case Kubes.env
    when "dev"
      "dev-db.cbuqdmc3nqvb.us-west-2.rds.amazonaws.com"
    when "prod"
      "prod-db.cbuqdmc3nqvb.us-west-2.rds.amazonaws.com"
    end
  end
end
```

The `database_endpoint` will be available to use in the `.kubes/resources` YAML files. IE:

.kubes/helpers/resources/shared/config_map.yaml

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: demo
  labels:
    app: demo
data:
  DATABASE_ENDPOINT: <%= database_endpoint %>
```

