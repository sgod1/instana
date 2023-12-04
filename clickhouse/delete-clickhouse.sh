#!/bin/bash

oc delete kafka instana -n instana-kafka
oc delete kafkauser strimzi-kafka-user -n instana-kafka
helm del strimzi -n instana-kafka

oc delete elasticsearch instana -n instana-elastic
helm del elastic-operator -n instana-elastic

oc delete postgresql postgres -n instana-postgres
helm del postgres-operator -n instana-postgres

oc delete cassandradatacenter cassandra -n instana-cassandra
helm del cass-operator -n instana-cassandra

oc delete chi instana -n instana-clickhouse-1
oc delete zk instana-zookeeper -n instana-clickhouse-1
helm del clickhouse-operator -n instana-clickhouse-1

helm del instana -n instana-zookeeper


