---
title: GKE Whitelisting
nav_text: GKE
categories: helpers-google
---

This page covers how to enable GKE IP Whitelisting. This feature is useful for deploying from a CloudBuild with GKE Private Clusters.

GKE Private Clusters whitelist and only allow authorized IPs to communicate with the Kubernetes control plane.  An issue with CloudBuild is that the IP address is not well-known.  Google creates a VM to run the CI scripts and throws it away when finished.  Kubes can detect the IP of the CloudBuild machine, add it to the cluster, deploy, and remove the IP afterward.

## Setup

To enable the GKE IP whitelisting feature, it's a single line:

.kubes/config/env/dev.rb

```ruby
KubesGoogle.configure do |config|
  config.gke.cluster_name = "projects/#{ENV['GOOGLE_PROJECT']}/locations/us-central1/clusters/dev-cluster"
end
```

This enables `kubes apply` before and after hooks to add and remove the current machine IP.

## Options

Here are the `config.gke` settings:

Name | Description | Default
---|---|---
cluster_name | GKE cluster name. This is required. | nil
enable_hooks | This will be true when the cluster_name is set. So there's no need to set it. The option provides a quick way to override and disable running the hooks. | true
whitelist_ip | Explicit IP to whitelist. By default the IP address of the current machine is automatically detected and used. | nil
