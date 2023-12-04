#!/bin/bash -x

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

# apply custom scc
oc apply -f $ENVROOT/datastores/clickhouse/security.openshift.io_v1_securitycontextconstraints_clickhouse-scc.yaml -n $CLICKHOUSE_NAMESPACE

helmrepo=${CLICKHOUSE_HELM_REPO}

helm repo add clickhouse-operator $helmrepo
helm repo update

# install helm release
helm install $CLICKHOUSE_HELM_RELEASE clickhouse-operator/altinity-clickhouse-operator --version=${CLICKHOUSE_OPERATOR_VERSION} -n $CLICKHOUSE_NAMESPACE
