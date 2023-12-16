#!/bin/bash

defaultenv=$1
versionenv=$2
customenv=$3

. $defaultenv
. $versionenv
. $customenv

set -x

oc apply -f $ENVROOT/datastores/postgres/security.openshift.io_v1_securitycontextconstraints_postgres-scc.yaml -n $POSTGRES_NAMESPACE

helm repo add postgres $POSTGRES_HELM_REPO
helm repo update

helm install $POSTGRES_HELM_RELEASE postgres/postgres-operator --version $POSTGRES_OPERATOR_VERSION \
  --set configGeneral.kubernetes_use_configmaps=true --set securityContext.runAsUser=101 -n $POSTGRES_NAMESPACE
