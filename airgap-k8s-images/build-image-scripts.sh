#!/bin/bash

envdir=$1
version=$2
local_image_registry=$3
docker_podman=${4:-"docker"}

./image-pull-builder.sh $envdir $version $docker_podman
./image-tag-builder.sh $envdir $version $local_image_registry $docker_podman
./image-push-builder.sh $envdir $version $local_image_registry $docker_podman
