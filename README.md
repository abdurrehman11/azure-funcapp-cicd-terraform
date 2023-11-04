# Setup Private Github package in Docker image
To setup private github packages in the docker image, follow the `line # 5 to 8 and 24 to 28` in the `Dockerfile`. Also, setup ssh key in cicd workflow, follow the `line # 31 to 59` in the `.github -> workflow -> functionapp_cicd.yml`

# Setup Github Secrets
Setup the following github secrets which are required for the cicd of application and infrastructure.
- `AZURE_CREDENTIALS` -> azure service_principal_object or relevant identity access
- `AZURE_FUNCTIONAPP_PUBLISH_PROFILE` -> azure function_app credentials (download from azure app page)
- `REGISTRY_LOGIN_SERVER` -> azure container registry login server url
- `REGISTRY_USERNAME` -> service principal clientId
- `REGISTRY_PASSWORD` -> service principal clientSecret
- `PRIVATE_REPO1_SSH` -> optional, your private repo1 ssh key
- `PRIVATE_REPO2_SSH` -> optional, your private repo2 ssh key

# Infastructure Deployment Instructions
This repo contains a directory `terraform` that will provision the azure function app with required resources.

## Build image and Push to ACR(Azure Container Registry)
To build iamge locally, run the following command from project root directory
```bash
docker build -t <login-server>/<image-name>:<tag>
```

To push the image to Azure container regsitry, run the following command,
```bash
docker push <login-server>/<image-name>:<tag>
```

## Provision the Azure Function App
- Go to this directory, `terraform -> azure_function_app` and then in `variables.tf`, change the following variables `docker_image_name`, `docker_image_tag`, `docker_custom_image_name` according to your image that you built in previous step.

- Go to directory, `terraform -> test` and then in `main.tf`, change the `application_name` and `environment_name` as required.

- Run the following commands from project root dir in order,
```bash
cd ./terraform/test
terraform init
terraform plan
terraform apply
```

# Application Deployment Instructions
- If you have already followed the Infrastructure Deployment instruction then you are ready to go, just do any change in your application as you want and then do git `commit` and `push` in `main branch` and `CI/CD pipeline` will trigger and deploy your updated application to azure function app.

- If you want to deploy azure function app with `consumption plan` which does not support container deployment, change the branch name (for example `main`) on which you want to trigger in `.github -> workflow -> funcapp_consumption_cicd.yml` and then do git `commit` and `push` in `main branch`. This will trigger the workflow and deploy your app.


## References
- https://learn.microsoft.com/en-us/azure/azure-functions/functions-how-to-github-actions?tabs=linux%2Cpython&pivots=method-manual
- https://learn.microsoft.com/en-us/answers/questions/151626/azure-functions-use-ssh-to-access-private-github-r
- https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-python?tabs=asgi%2Capplication-level&pivots=python-mode-configuration#environment-variables
- https://www.letsdevops.net/post/letsdevops-deploy-python-function-to-azure-function-app-using-github-actions-ci-cd
- https://learn.microsoft.com/en-us/azure/azure-functions/functions-deploy-container?tabs=acr%2Cbash%2Cazure-cli&pivots=programming-language-python
- https://github.com/Azure/actions-workflow-samples/blob/master/FunctionApp/linux-container-functionapp-on-azure.yml
- https://learn.microsoft.com/en-us/azure/azure-functions/functions-how-to-custom-container?tabs=core-tools%2Cacr%2Cazure-cli&pivots=azure-functions
- https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal
- https://learn.microsoft.com/en-us/azure/container-instances/container-instances-github-action?tabs=userlevel
- https://learn.microsoft.com/en-us/azure/role-based-access-control/overview
- https://medium.com/@tonistiigi/build-secrets-and-ssh-forwarding-in-docker-18-09-ae8161d066
- https://docs.docker.com/engine/reference/commandline/buildx_build/
- https://github.com/docker/build-push-action
- https://docs.docker.com/engine/reference/commandline/buildx_build/#secret
- https://docs.docker.com/engine/reference/commandline/buildx_build/#ssh
- https://docs.docker.com/build/ci/github-actions/push-multi-registries/
- https://docs.docker.com/build/ci/github-actions/secrets/
- https://stackoverflow.com/questions/55929417/how-to-securely-git-clone-pip-install-a-private-repository-into-my-docker-image/59455653#59455653
- https://docs.docker.com/storage/bind-mounts/
