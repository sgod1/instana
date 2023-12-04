#!/bin/bash

defaultenv=$1
versionenv=$2
customenv=$3
outdir=$4

. $defaultenv
. $versionenv
if test -f $customenv; then . $customenv; fi

version=$INSTANA_VERSION

mkdir -p $outdir
out=`readlink -f $outdir`

cat <<EOF > $out/zookeeper-operator-namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: $ZOOKEEPER_OPERATOR_NAMESPACE
EOF

cat <<EOF > $out/kafka-namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: $KAFKA_NAMESPACE
EOF

cat <<EOF > $out/cassandra-namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: $CASSANDRA_NAMESPACE
EOF

cat <<EOF > $out/clickhouse-namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: $CLICKHOUSE_NAMESPACE
EOF

cat <<EOF > $out/postgres-namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: $POSTGRES_NAMESPACE
EOF

cat <<EOF > $out/elastic-namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: $ELASTIC_NAMESPACE
EOF

cat <<EOF > $out/beeinstana-namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: $BEEINSTANA_NAMESPACE
EOF

cat <<EOF > $out/instana-operator-namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: $INSTANA_OPERATOR_NAMESPACE
EOF

# instana-core namespace
cat <<EOF > $out/instana-core-namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: $INSTANA_CORE_NAMESPACE
  labels:
    app.kubernetes.io/name: $INSTANA_CORE_NAMESPACE
EOF

# instana-unit namespace
cat <<EOF > $out/instana-unit-namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: $INSTANA_UNIT_NAMESPACE
  labels:
    app.kubernetes.io/name: $INSTANA_UNIT_NAMESPACE
EOF
