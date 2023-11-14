#!/bin/bash

secret_name=$1
values_file=$2

if test -z $secret_name; then
  echo secret name argument is required
  exit 1
fi

if test -z $values_file; then
  echo values_file argument required
  exit 1
fi

cat <<EOF > $values_file

impagePullSecrets:
  - name: $secret_name
EOF
