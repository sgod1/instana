#!/bin/bash

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

version="version-$INSTANA_VERSION"

versiondir=$GITROOT/$version
outdir=$ENVROOT/instana/instana-units

echo apply instana unit...

# create unit-config.yaml
$GITROOT/instana-units/unit-config.sh $defaultenv $versionenv $customenv $outdir

$KUBECTL delete secret $INSTANA_TENANT_NAME-$INSTANA_UNIT_NAME --namespace $INSTANA_UNIT_NAMESPACE
$KUBECTL create secret generic $INSTANA_TENANT_NAME-$INSTANA_UNIT_NAME --namespace $INSTANA_UNIT_NAMESPACE --from-file=config.yaml=$outdir/unit-config.yaml

# apply unit.yaml
$KUBECTL apply -f $outdir/instana.io_v1beta2_unit_$INSTANA_TENANT_NAME-$INSTANA_UNIT_NAME.yaml -n $INSTANA_UNIT_NAMESPACE
