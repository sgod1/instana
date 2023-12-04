#!/bin/bash -x

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

# we rely on `clickhouse-image-secret` created by external script
#kubectl create secret docker-registry clickhouse-image-secret \
#  --namespace=$CLICKHOUSE_NAMESPACE \
#  --docker-username=_ \
#  --docker-password=<AGENT_KEY> \
#  --docker-server=artifact-public.instana.io

# zookeeper cluster
oc apply -f $ENVROOT/datastores/clickhouse/zookeeper.pravega.io_v1beta1_zookeepercluster_instana-zookeeper.yaml -n $CLICKHOUSE_NAMESPACE

# clickhouse cluster
oc apply -f $ENVROOT/datastores/clickhouse/clickhouse.altinity.com_v1_clickhouseinstallation_instana.yaml -n $CLICKHOUSE_NAMESPACE
