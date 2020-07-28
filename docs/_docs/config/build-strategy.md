---
title: Build Strategy
---

Kubes uses the `docker` to build the docker image by default. Kubes can also support an additional build strategy: gcloud.

## Gcloud Build Strategy

With the gcloud build strategy, you do not need docker installed locally. Google CloudBuild is used to build and push the image to a GCR registry.

You must set up the [gcloud cli](https://cloud.google.com/sdk/gcloud/reference/builds/submit).  Please refer to the [gcloud sdk install docs](https://cloud.google.com/sdk/install). Kubes will call out to `gcloud builds submit` to create the Docker image.

## Configure

You configure gcloud as the build strategy like so:

```ruby
Kubes.configure do |config|
  config.repo = "gcr.io/#{ENV['GOOGLE_PROJECT']}/demo"
  config.logger.level = "info"
  config.build_strategy = "gcloud" # <= changed to gcloud
end
```

## Commands

The kubes builds command will remain the same.

    kubes docker build

There is no need to run the push command, as the build command with the gcloud strategy will always push.

## Deploy

The deploy commands remain the same. Example:

    kubes deploy web

If you want to skip the `docker build` phase of the deploy, you can run:

    kubes deploy web --no-build

Also, kubes apply another way to skip the docker build:

    kubes apply web

