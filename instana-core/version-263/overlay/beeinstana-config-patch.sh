#!/bin/bash

defaultenv=$1
versionenv=$2
customenv=$3
outdir=`readlink -f $4`

. $defaultenv
. $versionenv
. $customenv

cat <<EOF > $outdir/beeinstana-config-patch.yaml
apiVersion: instana.io/v1beta2
kind: Core
metadata:
  name: instana-core
spec:
  datastoreConfigs:
    beeInstanaConfig:
      hosts:
        - aggregators.$BEEINSTANA_NAMESPACE.svc
EOF
