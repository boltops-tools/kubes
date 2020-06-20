You'll need a Kubernetes cluster and a Docker repo to be able to push to. Setting up a Kubernetes cluster is a little bit out scope for this tutorial. We'll provide the docs and links though. We'll also use an AWS EKS cluster and ECR.

## Create an EKS cluster

Here are the AWS docs to create an EKS cluster:

* [Creating an Amazon EKS cluster](https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html)

## Create an ECR Repo

Here are the AWS docs to create a repo:

* [Creating a Repository](https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-create.html)

Here are also the commands to create an ECR repo:

    aws ecr create-repository --repository-name demo
    REPO=$(aws ecr describe-repositories --repository-name demo | jq -r '.repositories[].repositoryUri')

We'll be using the `$REPO` variable for the rest of the tutorial.

Note: Though we're using AWS here, Kubes works with any Cloud Provider. Please adjust your commands and the `$REPO` variable for your cloud provider.
