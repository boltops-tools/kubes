# Docker

Kubes builds docker images by calling the docker build commands.  Example:

    kubes docker build

## Deploy

While build the docker image as a separate step can be useful, most of the time you can just use the deploy command and kubes will automatically build the Docker image for you. Example:

    kubes deploy demo-web

If you want to skip the `docker build` as part of the deploy, you can run:

    kubes deploy demo-web --no-build
