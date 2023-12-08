#!/bin/bash

defaultenv=$1
versionenv=$2
customenv=$3
outdir=`readlink -f $4`

. $defaultenv
. $versionenv
. $customenv

cat <<EOF > $outdir/clickhouse-users-patch.yaml
apiVersion: "clickhouse.altinity.com/v1"
kind: "ClickHouseInstallation"
metadata:
  name: "instana"
spec:
  configuration:
    users:
      ${CLICKHOUSE_ADMIN}/password: ${CLICKHOUSE_ADMIN_PASSWORD}
      ${CLICKHOUSE_USER}/password: ${CLICKHOUSE_USER_PASSWORD}
EOF
