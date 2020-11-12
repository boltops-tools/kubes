---
title: AWS Kubes Plugin
---

The AWS Kubes Plugin adds support helpers like `aws_secret`. You can configure it's behavior. Example:

.kubes/config.rb

```ruby
KubesAws.configure do |config|
  config.secrets.base64 = false
end
```

## Options Reference Table

Here's a table with the options:

Name | Description | Default
---|---|---
secrets.base64 | Whether or not to automatically base64 encoded values returned by the `aws_secret` helper. | true
