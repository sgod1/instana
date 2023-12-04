#!/bin/bash

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

oc delete kafka/instana -n $KAFKA_NAMESPACE
oc delete kafkauser/strimzi-kafka-user -n $KAFKA_NAMESPACE
helm del $KAFKA_HELM_RELEASE -n $KAFKA_NAMESPACE
