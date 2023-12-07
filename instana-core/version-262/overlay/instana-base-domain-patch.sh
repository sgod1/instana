#!/bin/bash

defaultenv=$1
versionenv=$2
customenv=$3
outdir=`readlink -f $4`

. $defaultenv
. $versionenv
. $customenv

cat <<EOF > $outdir/instana-base-domain-patch.yaml
apiVersion: instana.io/v1beta2
kind: Core
metadata:
  name: instana-core
spec:
  # Base domain for Instana
  baseDomain: ${INSTANA_BASE_DOMAIN}
EOF
