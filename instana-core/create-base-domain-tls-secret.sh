#!/bin/bash -x

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

outdir=$ENVROOT/instana/instana-core

# create ingress cert
$GITROOT/instana-core/core-create-ingress-cert.sh $defaultenv $versionenv $customenv $outdir

# create tls ingress secret from ingres cert
$KUBECTL create secret tls instana-tls --namespace $INSTANA_CORE_NAMESPACE --cert=$outdir/tls.crt --key=$outdir/tls.key --dry-run=client -o yaml > $outdir/instana-tls.yaml
$KUBECTL apply -f $outdir/instana-tls.yaml
