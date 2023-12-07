#!/bin/bash

defaultenv=$1
versionenv=$2
customenv=$3
outdir=`readlink -f $4`

. $defaultenv
. $versionenv
. $customenv

cat <<EOF > $outdir/instana-agent-acceptor-patch.yaml
apiVersion: instana.io/v1beta2
kind: Core
metadata:
  name: instana-core
spec:
  agentAcceptorConfig:
    host: ${INSTANA_AGENT_ACCEPTOR}
EOF
