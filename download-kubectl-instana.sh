#!/bin/bash -x

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

download_key=$INSTANA_DOWNLOAD_KEY
envdir=$ENVROOT
release=$KUBECTL_INSTANA_RELEASE
os=$KUBECTL_INSTANA_OS
arch=$KUBECTL_INSTANA_ARCH
subrelease=$KUBECTL_INSTANA_SUBRELEASE
version=$INSTANA_VERSION

kubectl_tar="kubectl-instana-${os}_${arch}-release-${release}-${subrelease}.tar.gz"

kubectl_instana_url="https://artifact-public.instana.io/artifactory/rel-generic-instana-virtual/infrastructure/kubectl/release-${release}/$kubectl_tar"

outdir=$envdir/bin
mkdir -p $outdir

user="_"
password=$download_key
wget --http-user=$user --http-password=$password -O $outdir/$kubectl_tar $kubectl_instana_url

tar zxvf $outdir/$kubectl_tar -C $outdir

chmod +x $outdir/kubectl-instana
