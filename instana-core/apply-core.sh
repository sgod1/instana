#!/bin/bash -x

outdir=`readlink -f $1`

defaultenv=`readlink -f $2`
versionenv=`readlink -f $3`
customenv=`readlink -f $4`

gitdir=`readlink -f $5`

. $defaultenv
. $versionenv
. $customenv

version="version-$INSTANA_VERSION"

versiondir=$gitdir/$version
outdir=$envdir/instana/instana-core

echo apply instana core...

# create dhparams file
openssl dhparam -out $outdir/dhparams.pem 2048

# create ingress cert
$gitdir/instana-core/core-create-ingres-cert.sh $defaultenv $versionenv $customenv $outdir

# create tls ingress secret from ingres cert
${KUBECTL} create secret tls instana-tls --namespace $INSTANA_CORE_NAMESPACE \
    --cert=$outdir/tls.crt \
    --key=$outdir/tls.key

# create self-signed service-provider cert
$gitdir/instana-core/core-create-internal-ss-cert.sh $defaultenv $versionenv $customenv $outdir

# create instana registry pull secret in instana-core namespace
oc create secret docker-registry instana-registry \
    --namespace=$INSTANA_CORE_NAMESPACE \
    --docker-username=_ \
    --docker-password=$INSTANA_DOWNLOAD_KEY \
    --docker-server=artifact-public.instana.io

# create core-config.yaml from core-config.sh
$gitdir/instana-core/$versiondir/runtime/core-config.sh $defaultenv $versionenv $customenv $outdir

# create instana-core secret from core-config.yaml
${KUBECTL} create secret generic instana-core --namespace $INSTANA_CORE_NAMESPACE --from-file=config.yaml=$outdir/core-config.yaml

# apply core.yaml
apply -f $outdir/core.yaml
