#!/bin/bash

defaultenv=$1
versionenv=$2
customenv=$3

. $defaultenv
. $versionenv
. $customenv

set -x

oc apply -f $ENVROOT/datastores/cassandra/security.openshift.io_v1_securitycontextconstraints_cassandra-scc.yaml -n $CASSANDRA_NAMESPACE

helm repo add k8ssandra $CASSANDRA_HELM_REPO
helm repo update

helm install $CASSANDRA_HELM_RELEASE k8ssandra/cass-operator --version ${CASSANDRA_OPERATOR_VERSION} \
  --set securityContext.runAsGroup=999 --set securityContext.runAsUser=999 -n ${CASSANDRA_NAMESPACE}
