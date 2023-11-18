#!/bin/bash

image_registry=$1
username=$2
password=$3
docker_podman=${4:-"docker"}

usage() {
   echo usage: login-local-registry.sh image-registry user password
}

if test -z $image_registry
then
   echo image_registry argument required
   usage
   exit 1
fi

if test -z $username
then
   echo username argument required
   usage
   exit 1
fi

if test -z $password
then
   echo password argument required
   usage
   exit 1
fi

$docker_podman login $image_registry -u "$username" -p "$password"
