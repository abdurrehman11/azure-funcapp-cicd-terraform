# syntax=docker/dockerfile:1

FROM alpine AS builder

RUN apk add --no-cache git openssh-client
RUN mkdir -p -m 0700 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
RUN --mount=type=ssh,id=repo1_ssh_key git clone git@github.com:abdurrehman11/<github_repo_name>.git /code/private_repo1
RUN --mount=type=ssh,id=repo2_ssh_key git clone git@github.com:abdurrehman11/<github_repo_name>.git /code/private_repo2

FROM mcr.microsoft.com/azure-functions/python:4-python3.10

ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true \
    AzureWebJobsFeatureFlags=EnableWorkerIndexing \
    AzureWebJobsStorage=""

RUN apt-get update && apt-get install -y git

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY --from=builder /code /code

RUN pip install /code/private_repo1
RUN rm -rf /code/private_repo1

RUN pip install /code/private_repo2
RUN rm -rf /code/private_repo2

COPY . /home/site/wwwroot
