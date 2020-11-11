---
title: AWS Kubes Plugin
---

The AWS Kubes Plugin adds support helpers like `aws_secret`. You can configure it's behavior. Example:

.kubes/config.rb

```ruby
KubesAws.configure do |config|
  config.base64_secrets = false
end
```

Name | Description | Default
---|---|---
base64_secrets | Whether or not to automatically base64 encoded values returned by the `aws_secret` helper. | true
