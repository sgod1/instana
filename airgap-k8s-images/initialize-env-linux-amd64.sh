#!/bin/bash

download_key=$1
envdir=$2
release=$3
subrelease=${4:-"0"}
version=${5:-"0"}

os="linux"
arch="amd64"

./initialize-env.sh "$download_key" "$envdir" "$release" "$os" "$arch" "$subrelease" "$version"
