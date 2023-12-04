#!/bin/bash

defaultenv=$1
versionenv=$2
customenv=$3
outdir=`readlink -f $4`

. $defaultenv
. $versionenv
if test -f $customenv; then . $customenv; fi

cat <<EOF > $outdir/clickhouse-zookeeper-host-patch.yaml
apiVersion: "clickhouse.altinity.com/v1"
kind: "ClickHouseInstallation"
metadata:
  name: "instana"
spec:
  configuration:
    zookeeper:
      nodes:
        - host: instana-zookeeper-headless.${CLICKHOUSE_NAMESPACE}
EOF
