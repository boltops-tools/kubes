---
title: GKE Whitelisting
nav_text: GKE
categories: helpers-google
---

This page covers how to enable GKE IP Whitelisting. This feature is useful for deploying from a CloudBuild with GKE Private Clusters.

GKE Private Clusters whitelist and only allow authorized IPs to communicate with the Kubernetes control plane.  An issue with CloudBuild is that the IP address is not well-known.  Google creates a VM to run the CI scripts and throws it away when finished.  Kubes can detect the IP of the CloudBuild machine, add it to the cluster, deploy, and remove the IP afterward.

## Setup

To enable the GKE IP whitelisting feature, it's a few simple configurations:

.kubes/config/env/dev.rb

```ruby
KubesGoogle.configure do |config|
  config.gke.cluster_name = "dev-cluster"
  config.gke.google_region = ENV['GOOGLE_REGION']
  config.gke.google_project = ENV['GOOGLE_PROJECT']
  config.gke.enable_get_credentials = true # enable hook to call: gcloud container clusters get-credentials
end
```

Note: The use of `KubesGoogle.configure` instead of `Kubes.configure` here.

This enables `kubes apply` before and after hooks to add and remove the current machine IP.

## Options

Here are the `config.gke` settings:

Name | Description | Default
---|---|---
{% include plugins/gke-config.md %}

## Build Docker Image

To build kubes as a Docker image entrypoint for [Google CloudBuild Custom Builder](https://cloud.google.com/cloud-build/docs/configuring-builds/use-community-and-custom-builders).

    git clone http://github.com/boltops-tools/kubes
    cd kubes
    gcloud builds submit --tag gcr.io/$GOOGLE_PROJECT/kubes

Be sure to set GOOGLE_PROJECT to your own project id.

## Example Codebuild YAML

cloudbuild.yaml:

```yaml
steps:
- name: 'gcr.io/$PROJECT_ID/kubes'
  args: ['deploy']
  env:
  - 'DOCKER_REPO=gcr.io/$PROJECT_ID/demo'
  - 'GOOGLE_PROJECT=$PROJECT_ID' # .kubes/config.rb: config.repo
  - 'KUBES_ENV=$_KUBES_ENV'
  - 'KUBES_EXTRA=$_KUBES_EXTRA'
  - 'KUBES_REPO_AUTO_AUTH=0'

substitutions:
  _KUBES_ENV: dev
  _KUBES_EXTRA: ''
options:
    substitution_option: 'ALLOW_LOOSE'
```

Make sure to replace the substitutions with your own values. IE: _KUBES_ENV, etc.

## Google CloudBuild IAM Permissions

In order to update the GKE cluster master authorized IP and whitelist the CloudBuild IP, you'll need to allow the CloudBuild IAM role permissions.

Important: The "Kubernetes Engine Developer" that is available in the Cloud Build Settings page as described in [Configuring access for Cloud Build Service Account](https://cloud.google.com/cloud-build/docs/securing-builds/configure-access-for-cloud-build-service-account) does not suffice. You'll need to add the "Kubernetes Engine Cluster Admin" role. Here are the steps:

1. Go to the Google IAM Console and search "cloudbuild"
2. Click "Edit Member"
3. Add the "Kubernetes Engine Cluster Admin" role

## Run CloudBuild

Run cloudbuild to deploy the dev env:

    gcloud builds submit --config cloudbuild.yaml

To deploy the prod env:

    gcloud builds submit --config cloudbuild.yaml --substitutions _KUBES_ENV=prod

See [gcloud builds submit](https://cloud.google.com/sdk/gcloud/reference/builds/submit) reference docs for more options.
