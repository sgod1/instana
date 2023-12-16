#!/bin/bash

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

set -x

$KUBECTL apply -f $ENVROOT/datastores/cassandra/cassandra.datastax.com_v1beta1_cassandradatacenter_cassandra.yaml -n $CASSANDRA_NAMESPACE
