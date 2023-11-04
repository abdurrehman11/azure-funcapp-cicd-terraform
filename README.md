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