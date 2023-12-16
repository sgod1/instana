#!/bin/bash

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

set -x

oc apply -f $ENVROOT/datastores/kafka/kafka.strimzi.io_v1beta2_kafka_instana.yaml -n $KAFKA_NAMESPACE
oc apply -f $ENVROOT/datastores/kafka/kafka.strimzi.io_v1beta2_kafkauser_strimzi-kafka-user.yaml -n $KAFKA_NAMESPACE
