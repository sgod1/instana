#!/bin/bash

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`
outdir=`readlink -f $4`

. $defaultenv
. $versionenv
. $customenv

cat <<EOF > $outdir/kafka-brokers-patch.yaml
apiVersion: beeinstana.instana.com/v1beta1
kind: BeeInstana
metadata:
  name: instance
spec:
  kafkaSettings:
    brokers:
      - instana-kafka-bootstrap.$KAFKA_NAMESPACE:9092
EOF
