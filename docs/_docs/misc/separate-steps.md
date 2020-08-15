---
title: Separate Steps
---

Sometimes you may want to run the 3 separate kubes steps directly. This may be useful if you are setting up CI/CD and need more control over the build process. Here are the 3 main steps:

To build and push the docker image:

    kubes docker build
    kubes docker push

Note, you must run a `kubes docker build` at least once. As the build step will store the image name in a `.kubes/state/docker_image.txt ` file for later use.

To compile the Kubernetes YAML files.

    kubes compile

To apply the Kubernetes YAML files in the correct order and create resources on the cluster:

    kubes apply

