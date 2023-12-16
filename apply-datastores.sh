#!/bin/bash

defaultenv=`readlink -f ./default.env`
versionenv=`readlink -f ./operator-versions.env`
customenv=`readlink -f ./custom.env`

. $defaultenv
. $versionenv
. $customenv

set -x

$GITROOT/kafka/apply-kafka.sh $defaultenv $versionenv $customenv

$GITROOT/elastic/apply-elastic.sh $defaultenv $versionenv $customenv

$GITROOT/postgres/apply-postgres.sh $defaultenv $versionenv $customenv

$GITROOT/cassandra/apply-cassandra.sh $defaultenv $versionenv $customenv

$GITROOT/clickhouse/apply-clickhouse.sh $defaultenv $versionenv $customenv

$GITROOT/beeinstana/apply-beeinstana.sh $defaultenv $versionenv $customenv
