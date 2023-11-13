#!/bin/bash -x

envdir=$1
version=$2
local_image_registry=$3
docker_podman=${4:-"docker"}

output_dir=$envdir/$version

builder() {
  input_list=$1
  output_script=$2
  cat $output_dir/$input_list | awk -v docker_podman=$docker_podman -v local_image_registry=$local_image_registry -f awk-image-tag.awk > $output_dir/$output_script
  chmod +x $output_dir/$output_script
}

input_list="instana-images.list"
output_script="tag-instana-images.sh"
builder $input_list $output_script

input_list="operator-images.list"
output_script="tag-operator-images.sh"
builder $input_list $output_script
