#!/bin/bash -x

envdir=$1
version=$2
docker_podman=${3:-"docker"}

output_dir=$envdir/$version

builder() {
  input_list=$1
  output_script=$2
  cat $output_dir/$input_list | awk -v docker_podman=$docker_podman -f awk-image-pull.awk > $output_dir/$output_script
  chmod +x $output_dir/$output_script
}

cp login-instana-image-registry.sh $output_dir

input_list="instana-images.list"
output_script="pull-instana-images.sh"
builder $input_list $output_script

input_list="operator-images.list"
output_script="pull-operator-images.sh"
builder $input_list $output_script
