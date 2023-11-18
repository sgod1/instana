#!/bin/bash

download_key=$1
docker_podman=${2:-"docker"}

instana_image_registry=artifact-public.instana.io

if test -z $download_key
then
   echo download_key argument required
   echo usage: login-instana-image-registry.sh download_key
   exit 1
fi

$docker_podman login $instana_image_registry -u "_" -p "$download_key"
