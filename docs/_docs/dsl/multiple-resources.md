---
title: Multiple Resources
---

Kubes encourages a structure with files that matches the resource kind. Example:

    .kubes
    └── resources
        └── web
            ├── deployment.rb
            └── service.rb

This structure is nicely organized and covers 80% of use cases. An astute user may point out that this struture assumes one resource of each kind.

Next, we'll cover different ways to create multiple resource of the same kinds.

## Multiple Resources: Multiple Files

You can create multiple resources of same kind by appending a dash followed by anything. Example:

    .kubes
    └── resources
        └── web
            ├── deployment-1.rb
            ├── deployment-2.rb
            ├── service-1.rb
            └── service-2.rb

Only words before the dash are used to infer the resource kind.

Filename | Resource Kind
--- | ---
deployment-1.rb | Deployment
deployment-2.rb | Deployment
service-1.rb | Service
service-2.rb | Service

Using multiple files is the general recommended approach.

## Multiple Resources: Block Form

You can also create multiple resources within the same file by declaring resources with a block form. When you use the block form, the file name is not used to infer the resource type. The resource kind is explicitly declare by the block method name. An example helps explain:

    .kubes
    └── resources
        └── web
            └── main.rb

.kubes/resources/web/main.rb

```ruby
deployment "demo-web" do
  labels(role: "web")
  replicas 1
  image built_image # IE: user/demo:kubes-2020-06-13T19-55-16-43afc6e
end

service "demo-web" do
  labels(role: "web")
end
```

You can declare deployment, service, and other resource kinds multiple times.

## Layering

Layering works for both multiple resources approaches. Just create a folder with the corresponding name.

However, the layering definitions must all be declare in the same form. So if you're using block form, you must use block form for everything. This includes base and environment-specific layering.
