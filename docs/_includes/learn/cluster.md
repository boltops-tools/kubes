You'll need a Kubernetes cluster and a Docker repo to be able to push to. Setting up a Kubernetes cluster is a little bit out scope for this tutorial. We'll provide the docs and links though. We'll provide instructions for AWS and Google.

## AWS: Create an EKS cluster

Here are the AWS docs to create an EKS cluster:

* [Creating an Amazon EKS cluster](https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html)

## AWS: Create an ECR Repo

Here are the AWS docs to create a repo:

* [Creating a Repository](https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-create.html)

Here are also the commands to create an ECR repo:

    aws ecr create-repository --repository-name demo
    REPO=$(aws ecr describe-repositories --repository-name demo | jq -r '.repositories[].repositoryUri')

We'll be using the `$REPO` variable for the rest of the tutorial.

## Google: Create GKE Cluster

Here are the Google docs to create an GKE cluster:

* [Creating an Google GKE cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-regional-cluster)

## Google: GCR Repo

For google, you do not have to create a repo. You simply push to the right repo url.  Example:

    export GOOGLE_PROJECT=project-123
    REPO=gcr.io/$GOOGLE_PROJECT/demo

## Repo Variable

We'll be using the `$REPO` variable for the rest of the tutorial.

Note: Though we're using AWS and Google here, Kubes works with any Cloud Provider. Please adjust your commands and the `$REPO` variable for your cloud provider.
