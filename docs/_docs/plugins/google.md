---
title: Google Kubes Plugin
---

The Google Kubes Plugin adds support helpers like `google_secret`. You can configure it's behavior. Example:

.kubes/config.rb

```ruby
KubesGoogle.configure do |config|
  config.base64_secrets = true
end
```

## Options Reference Table

Here's a table with the options:

Name | Description | Default
---|---|---
base64_secrets | Whether or not to automatically base64 encoded values returned by the `google_secret` helper. | true
{% include plugins/gke-config.md %}