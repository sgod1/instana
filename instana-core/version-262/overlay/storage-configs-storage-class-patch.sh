#!/bin/bash

defaultenv=$1
versionenv=$2
customenv=$3
outdir=`readlink -f $4`

. $defaultenv
. $versionenv
. $customenv

cat <<EOF > $outdir/storage-configs-storage-class-patch.yaml
apiVersion: instana.io/v1beta2
kind: Core
metadata:
  name: instana-core
spec:
  storageConfigs:
    rawSpans:
      pvcConfig:
        storageClassName: ${RWX_STORAGECLASS}
    synthetics:
      pvcConfig:
        storageClassName: ${RWX_STORAGECLASS}
    syntheticsKeystore:
      pvcConfig:
        storageClassName: ${RWX_STORAGECLASS}
EOF
