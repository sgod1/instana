#!/bin/bash

download_key=$1
envdir=$2
release=$3
os=$4
arch=$5
subrelease=${6:-"0"}
version=${7:-"0"}

check_dowload_key() {
  if test -z $download_key; then
    echo download_key argument required
    exit 1
  fi
}

check_envdir() {
  if test -z $envdir; then
    echo envdir argument required
    exit 1
  fi
}

check_release() {
  if test -z $release; then
    echo release argument required
    exit 1
  fi
}

check_os() {
  if test -z $os; then
    echo os argument required
    exit 1
  fi
}

check_arch() {
  if test -z $arch; then
    echo arch argument required
    exit 1
  fi
}

check_dowload_key
check_envdir
check_release
check_os
check_arch

./download-kubectl-instana.sh $download_key $envdir $release $os $arch $subrelease $version

if test $? -ne 0; then
  exit $?
fi

./copy-env-template.sh $envdir $release $subrelease $version
exit $?
