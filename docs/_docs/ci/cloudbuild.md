---
title: CloudBuild
---

To build kubes as a Docker image entrypoint for [Google CloudBuild Custom Builder](https://cloud.google.com/cloud-build/docs/configuring-builds/use-community-and-custom-builders).

    git clone http://github.com/boltops-tools/kubes
    cd kubes
    gcloud builds submit --tag gcr.io/$GOOGLE_PROJECT/kubes

Be sure to set GOOGLE_PROJECT to your own project id.

## Example Codebuild YAML

cloudbuild.yaml:

```yaml
steps:
# Simply calling kubectl version with the CLOUDSDK_* vars will auth to the GKE cluster. Unsure why.
- name: gcr.io/cloud-builders/kubectl
  args: ['version']
  env:
  - 'CLOUDSDK_COMPUTE_REGION=$_GCP_REGION'
  - 'CLOUDSDK_CONTAINER_CLUSTER=$_GKE_CLUSTER'
- name: 'gcr.io/$PROJECT_ID/kubes'
  args: ["deploy"]
  env:
  - 'GOOGLE_PROJECT=$PROJECT_ID' # .kubes/config.rb: config.repo
  - 'KUBES_ENV=$_KUBES_ENV'
  - 'KUBES_EXTRA=$_KUBES_EXTRA'

substitutions:
  _GCP_REGION: us-central1
  _GKE_CLUSTER: dev-cluster
  _KUBES_ENV: dev
  _KUBES_EXTRA: ''
options:
    substitution_option: 'ALLOW_LOOSE'
```

## Run CloudBuild

Run cloudbuild with:

    gcloud builds submit --config cloudbuild.yaml

Example with output:

    $ gcloud builds submit --config cloudbuild.yaml
    Starting Step #1
    Step #1: => docker build -t gcr.io/tung-275700/demo:kubes-2020-07-25T21-13-59 -f Dockerfile .
    Step #1: Pushed gcr.io/tung-275700/demo:kubes-2020-07-25T21-13-59 docker image.
    Step #1: Docker push took 2s.
    Step #1: Compiled  .kubes/resources files to .kubes/output
    Step #1: Deploying kubes resources
    Step #1: => kubectl apply -f .kubes/output/shared/namespace.yaml
    Step #1: namespace/demo unchanged
    Step #1: => kubectl apply -f .kubes/output/web/service.yaml
    Step #1: service/web unchanged
    Step #1: => kubectl apply -f .kubes/output/web/deployment.yaml
    Step #1: deployment.apps/web configured
    $

## Create Extra Environments

If you are using the [with_extra helper]({% link _docs/extra-env.md %}), you can create additional environments of the same app like so:

    gcloud builds submit --config cloudbuild.yaml --substitutions=_KUBES_EXTRA=2
    gcloud builds submit --config cloudbuild.yaml --substitutions=_KUBES_EXTRA=3
