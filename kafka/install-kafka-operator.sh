#!/bin/bash -x

defaultenv=$1
versionenv=$2
customenv=$3

. $defaultenv
. $versionenv

if test -f $customenv; then
  . $customenv
fi

helm repo add strimzi $KAFKA_HELM_REPO
helm repo update

helm install $KAFKA_HELM_RELEASE strimzi/strimzi-kafka-operator --version ${KAFKA_OPERATOR_VERSION} -n ${KAFKA_NAMESPACE}
