#!/bin/bash

download_key=$1
envdir=$2
release=$3
os=$4
arch=$5
subrelease=$6
version=$7

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

check_subrelease() {
  if test -z $subrelease; then
    echo subrelease argument required
    exit 1
  fi
}

check_version() {
  if test -z $version; then
    echo version argument required
    exit 1
  fi
}

check_dowload_key
check_envdir
check_release
check_os
check_arch
check_subrelease
check_version

kubectl_tar="kubectl-instana-${os}_${arch}-release-${release}-${subrelease}.tar.gz"

kubectl_instana_url="https://artifact-public.instana.io/artifactory/rel-generic-instana-virtual/infrastructure/kubectl/release-${release}/$kubectl_tar"

outdir=$envdir/$version
mkdir -p $outdir

user="_"
password=$download_key
wget --http-user=$user --http-password=$password -O $outdir/$kubectl_tar $kubectl_instana_url

tar zxvf $outdir/$kubectl_tar -C $outdir
