#!/bin/bash -x

defaultenv=$1
versionenv=$2
customenv=$3

. $defaultenv
. $versionenv

if test -f $customenv; then . $customenv; fi

oc apply -f $ENVROOT/datastores/cassandra/security.openshift.io_v1_securitycontextconstraints_cassandra-scc.yaml

helm repo add k8ssandra $CASSANDRA_HELM_REPO
helm repo update

helm install $CASSANDRA_HELM_RELEASE k8ssandra/cass-operator --version ${CASSANDRA_OPERATOR_VERSION} \
  --set securityContext.runAsGroup=999 --set securityContext.runAsUser=999 -n ${CASSANDRA_NAMESPACE}
