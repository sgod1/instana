#!/bin/bash -x

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

version="version-$INSTANA_VERSION"

versiondir=$GITROOT/instana-core/$version
outdir=$ENVROOT/instana/instana-core

echo apply instana core...

# create dhparams file
if test ! -f $outdir/dhparams.pem; then
  openssl dhparam -out $outdir/dhparams.pem 2048
fi

# create base domain tls secret
$GITROOT/instana-core/create-base-domain-tls-secret.sh $defaultenv $versionenv $customenv

# create self-signed service-provider cert
$GITROOT/instana-core/core-create-internal-ss-cert.sh $defaultenv $versionenv $customenv $outdir

# create core-config.yaml from core-config.sh
$versiondir/runtime/core-config.sh $defaultenv $versionenv $customenv $outdir

# create instana-core secret from core-config.yaml
$KUBECTL delete secret instana-core -n $INSTANA_CORE_NAMESPACE
$KUBECTL create secret generic instana-core --namespace $INSTANA_CORE_NAMESPACE --from-file=config.yaml=$outdir/core-config.yaml

# create instana registry pull secret in instana-core namespace
$KUBECTL apply -f $ENVROOT/instana/instana-registry.yaml -n $INSTANA_CORE_NAMESPACE

# apply core.yaml
$KUBECTL apply -f $outdir/instana.io_v1beta2_core_instana-core.yaml -n $INSTANA_CORE_NAMESPACE
