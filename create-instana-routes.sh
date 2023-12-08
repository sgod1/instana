#!/bin/bash -x

defaultenv=`readlink -f ./default.env`
versionenv=`readlink -f ./operator-versions.env`
customenv=`readlink -f ./custom.env`

. $defaultenv
. $versionenv
. $customenv

echo "Creating routes..."

$KUBECTL create route passthrough acceptor --hostname=$INSTANA_AGENT_ACCEPTOR --service=acceptor  --port=8600 -n $INSTANA_CORE_NAMESPACE

$KUBECTL create route passthrough base-domain --hostname=$INSTANA_BASE_DOMAIN --service=gateway --port=https -n $INSTANA_CORE_NAMESPACE

$KUBECTL create route passthrough $INSTANA_UNIT_NAME-$INSTANA_TENANT_NAME-ui --hostname=$INSTANA_TENANT_DOMAIN --service=gateway --port=https -n $INSTANA_CORE_NAMESPACE

#${KUBECTL} create route passthrough ui-client-tenant --hostname=${INSTANA_TENANT_DOMAIN} --service=gateway --port=https -n instana-core
#${KUBECTL} create route passthrough ui-client-ssl --hostname=${INSTANA_BASE_DOMAIN} --service=gateway --port=https -n instana-core
#${KUBECTL} create route passthrough acceptor  --hostname=${INSTANA_AGENT_ACCEPTOR}  --service=acceptor  --port=8600  -n instana-core
