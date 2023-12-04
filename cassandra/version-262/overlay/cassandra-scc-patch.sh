#!/bin/bash

defaultenv=$1
versionenv=$2
customenv=$3
outdir=`readlink -f $4`

. $defaultenv
. $versionenv
if test -f $customenv; then . $customenv; fi

cat <<EOF > $outdir/cassandra-scc-patch.yaml
apiVersion: security.openshift.io/v1
kind: SecurityContextConstraints
metadata:
  name: cassandra-scc
users:
  - system:serviceaccount:${CASSANDRA_NAMESPACE}:cass-operator
  - system:serviceaccount:${CASSANDRA_NAMESPACE}:default
EOF
