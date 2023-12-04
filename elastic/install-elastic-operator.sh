#!/bin/bash -x

defaultenv=$1
versionenv=$2
customenv=$3

. $defaultenv
. $versionenv

if test -f $customenv; then
  . $customenv
fi

helm repo add elastic $ELASTIC_HELM_REPO
helm repo update

helm install $ELASTIC_HELM_RELEASE elastic/eck-operator --version ${ELASTIC_OPERATOR_VERSION} -n ${ELASTIC_NAMESPACE}
