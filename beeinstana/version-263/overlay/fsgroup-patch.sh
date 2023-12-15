#!/bin/bash

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`
outdir=`readlink -f $4`

. $defaultenv
. $versionenv
. $customenv

cat <<EOF > $outdir/fsgroup-patch.yaml
apiVersion: beeinstana.instana.com/v1beta1
kind: BeeInstana
metadata:
  name: instance
spec:
  fsGroup: `$KUBECTL get namespace $BEEINSTANA_NAMESPACE -o jsonpath='{.metadata.annotations.openshift\.io\/sa\.scc\.uid-range}' | cut -d/ -f 1`
EOF
