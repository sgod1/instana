#!/bin/bash

defaultenv=$1
versionenv=$2
customenv=$3
outdir=`readlink -f $4`

. $defaultenv
. $versionenv
if test -f $customenv; then . $customenv; fi

cat <<EOF > $outdir/clickhouse-scc-patch.yaml
apiVersion: security.openshift.io/v1
kind: SecurityContextConstraints
metadata:
  name: clickhouse-scc
users:
  - system:serviceaccount:${CLICKHOUSE_NAMESPACE}:clickhouse-operator-altinity-clickhouse-operator
  - system:serviceaccount:${CLICKHOUSE_NAMESPACE}:default
EOF
