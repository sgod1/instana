#!/bin/bash

defaultenv=$1
versionenv=$2
customenv=$3
outdir=`readlink -f $4`

. $defaultenv
. $versionenv
. $customenv

cat <<EOF > $outdir/clickhouse-configs-patch.yaml
apiVersion: instana.io/v1beta2
kind: Core
metadata:
  name: instana-core
spec:
  datastoreConfigs:
    clickhouseConfigs:
      - clusterName: local
        authEnabled: true
        hosts:
          - chi-instana-local-0-0.${CLICKHOUSE_NAMESPACE}
        ports:
          - name: tcp
            port: 9000
          - name: http
            port: 8123
        schemas:
          - application
          - logs
          - synthetics
EOF
