---
title: Docker Config
---

## General

Kubes builds docker images by calling the docker build commands.  Example:

    kubes docker build

To push:

    kubes docker push

## Deploy

While building the docker image as a separate step can be useful, you can just use the deploy command, and kubes will automatically build the Docker image for you. Example:

    kubes deploy web

If you want to skip the `docker build` phase of the deploy, you can run:

    kubes deploy web --no-build

Also, kubes apply another way to skip the docker build:

    kubes apply web

## Customizing Args and Hooks

See:

* [Docker Args Docs]({% link _docs/config/args/docker.md %})
* [Docker Hooks Docs]({% link _docs/config/hooks/docker.md %})
