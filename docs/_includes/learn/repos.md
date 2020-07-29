For this tutorial, here are examples of AWS ECR and Google GCR repos, though any repo will work.

AWS:

    REPO=$(aws ecr describe-repositories --repository-name demo | jq -r '.repositories[].repositoryUri')

Google:

    export GOOGLE_PROJECT=project-123
    REPO=gcr.io/$GOOGLE_PROJECT/demo
