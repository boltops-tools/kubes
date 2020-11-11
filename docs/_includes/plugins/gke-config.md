gke.cluster_name | GKE cluster name. This is required when using the [GKE whitelisting feature]({% link _docs/helpers/google/gke.md %}). | nil
gke.enable_get_credentials | Whether or not to run the hook that calls `gcloud container clusters get-credentials`. This spares you from having to call it manually. | false
gke.enable_hooks | This will be true when the cluster_name is set. So there's no need to set it. The option provides a quick way to override and disable running the hooks. | true
gke.google_project | Google project. Can also be set with the env var `GOOGLE_PROJECT`. `GOOGLE_PROJECT` takes precedence. | nil
gke.google_region | Google region cluster is in. Can also be set with the env var `GOOGLE_REGION`. `GOOGLE_REGION` takes precedence. | nil
gke.whitelist_ip | Explicit IP to whitelist. By default the IP address of the current machine is automatically detected and used. | nil