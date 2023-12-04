#!/bin/bash

defaultenv=$1
versionenv=$2
customenv=$3
outdir=`readlink -f $4`

. $defaultenv
. $versionenv
if test -f $customenv; then . $customenv; fi

cat <<EOF > $outdir/postgres-scc-patch.yaml
apiVersion: security.openshift.io/v1
kind: SecurityContextConstraints
metadata:
  name: postgres-scc
users:
  - system:serviceaccount:${POSTGRES_NAMESPACE}:postgres-operator
  - system:serviceaccount:${POSTGRES_NAMESPACE}:postgres-pod
  - system:serviceaccount:${POSTGRES_NAMESPACE}:default
EOF
