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

You can also use a block form to create multiple resources.  The multiple resources block form is an experimental feature.

You name the resource files with plural names. An example helps explain:

    .kubes
    └── resources
        └── deployments.rb

.kubes/resources/web/deployments.rb

```ruby
deployment "demo-web" do
  labels(role: "web")
  replicas 1
  image docker_image # IE: user/demo:kubes-2020-06-13T19-55-16-43afc6e
end

deployment "demo-web-2" do
  labels(role: "web")
  replicas 1
  image docker_image # IE: user/demo:kubes-2020-06-13T19-55-16-43afc6e
end
```

You can also mix and matched resources. When you use the block form, the file name is not used to infer the resource type. The resource kind is explicitly declare by the block method name.


.kubes/resources/web/resources.rb

```ruby
deployment "demo-web" do
  labels(role: "web")
  replicas 1
  image docker_image # IE: user/demo:kubes-2020-06-13T19-55-16-43afc6e
end

service "demo-web" do
  labels(role: "web")
end
```

You can declare deployment, service, and other resource kinds multiple times.

## Layering

Layering works for both simple and block form. Just create a folder with the corresponding name.

* The layering definitions with the simple form only merge with other simple form layers.
* The layering definitions for block forms only merge with other block form layers.

Simple form layering:

    .kubes/resources/
    ├── base
    │   ├── all.rb
    │   └── deployment.rb
    └── web
        ├── deployment
        │   ├── dev.rb
        │   └── prod.rb
        └── deployment.rb

Block form layering:

    .kubes/resources/
    ├── base
    │   ├── alls.rb
    │   └── deployments.rb
    └── web
        ├── deployments
        │   ├── dev.rb
        │   └── prod.rb
        └── deployments.rb

The main difference are pluralized filenames.
