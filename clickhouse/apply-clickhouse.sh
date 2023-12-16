#!/bin/bash

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

set -x

# image pull secret
oc apply -f $ENVROOT/instana/instana-registry.yaml -n $CLICKHOUSE_NAMESPACE

# zookeeper cluster
oc apply -f $ENVROOT/datastores/clickhouse/zookeeper.pravega.io_v1beta1_zookeepercluster_instana-zookeeper.yaml -n $CLICKHOUSE_NAMESPACE

# clickhouse cluster
oc apply -f $ENVROOT/datastores/clickhouse/clickhouse.altinity.com_v1_clickhouseinstallation_instana.yaml -n $CLICKHOUSE_NAMESPACE
