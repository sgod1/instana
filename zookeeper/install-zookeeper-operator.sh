#!/bin/bash -x

defaultenv=$1
versionenv=$2
customenv=$3

. $defaultenv
. $versionenv

if test -f $customenv; then . $customenv; fi

helm repo add pravega $ZOOKEEPER_HELM_REPO
helm repo update

helm install $ZOOKEEPER_HELM_RELEASE pravega/zookeeper-operator --version ${ZOOKEEPER_OPERATOR_VERSION} -n ${ZOOKEEPER_OPERATOR_NAMESPACE}
