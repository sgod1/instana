#!/bin/bash

# if secret is for artifact-public.instana.io, then user is "_", and password is download key

namespace=$1
secret_name=$2
docker_username=$3
docker_password=$4

kubectl create secret docker-registry $secret_name \
    --namespace=$namespace \
    --docker-username=$docker_username \
    --docker-password=$docker_password \
    --docker-server=artifact-public.instana.io
