#!/bin/bash

defaultenv=`readlink -f ./default.env`
versionenv=`readlink -f ./operator-versions.env`
customenv=`readlink -f ./custom.env`

. $defaultenv
. $versionenv
. $customenv

$GITROOT/zookeeper/install-zookeeper-operator.sh $defaultenv $versionenv $customenv

$GITROOT/kafka/install-kafka-operator.sh $defaultenv $versionenv $customenv

$GITROOT/elastic/install-elastic-operator.sh $defaultenv $versionenv $customenv

$GITROOT/postgres/install-postgres-operator.sh $defaultenv $versionenv $customenv

$GITROOT/cassandra/install-cassandra-operator.sh $defaultenv $versionenv $customenv

$GITROOT/clickhouse/install-clickhouse-operator.sh $defaultenv $versionenv $customenv

# beeinstana/install-beeinstana-operator.sh $defaultenv $versionenv $customenv
