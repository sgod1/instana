#!/bin/bash

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

set -x

# beeinstana password
$KUBECTL delete secret beeinstana-admin-creds
$KUBECTL create secret generic beeinstana-admin-creds -n $BEEINSTANA_NAMESPACE \
  --from-literal=username=beeinstana-user \
  --from-literal=password=${BEEINSTANA_ADMIN_PASSWORD}

# kafka user password
$KUBECTL delete secret beeinstana-kafka-creds
$KUBECTL create secret generic beeinstana-kafka-creds -n $BEEINSTANA_NAMESPACE \
  --from-literal=username=strimzi-kafka-user \
  --from-literal=password=`${KUBECTL} get secret strimzi-kafka-user  -n $KAFKA_NAMESPACE --template='{{index .data.password | base64decode}}'`

# apply beeinstana
$KUBECTL apply -f $ENVROOT/datastores/beeinstana/beeinstana.instana.com_v1beta1_beeinstana_instance.yaml -n $BEEINSTANA_NAMESPACE
