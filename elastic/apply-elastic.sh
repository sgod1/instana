#!/bin/bash -x

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

oc apply -f $ENVROOT/datastores/elastic/elasticsearch.k8s.elastic.co_v1_elasticsearch_instana.yaml -n $ELASTIC_NAMESPACE
#oc wait elasticsearch/instana --for=condition=ReconciliationComplete --timeout=300s -n $ELASTIC_NAMESPACE
