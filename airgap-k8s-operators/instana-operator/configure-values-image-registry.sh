#!/bin/bash

image_registry=$1
values_file=$2

if test -z $image_registry; then
  echo image_registry argument required
  exit 1
fi

if test -z $values_file; then
  echo values_file argument required
  exit 1
fi

cat <<EOF >> values_file

image:
  registry: $image_registry
EOF
