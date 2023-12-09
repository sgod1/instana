#!/bin/bash

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
cusomenv=`readlink -f $3`

outdir=`readlink -f $4`

. $defaultenv
. $versionenv
. $cusomenv

cat <<EOF > $outdir/core-config.yaml
# Diffie-Hellman parameters to use
dhParams: |
`sed  's/^/  /' $outdir/dhparams.pem`
# The download key you received from us
repositoryPassword: ${INSTANA_DOWNLOAD_KEY}
# The sales key you received from us
salesKey: ${INSTANA_SALES_KEY}
# Seed for creating crypto tokens. Pick a random 12 char string
tokenSecret: ${INSTANA_CORE_TOKEN_SECRET}
# Configuration for raw spans storage
storageConfigs:
#  rawSpans:
#    # Required if using S3 or compatible storage bucket.
#    # Credentials should be configured.
#    # Not required if IRSA on EKS is used.
#    s3Config:
#      accessKeyId: ...
#      secretAccessKey: ...
#    # Required if using Google Cloud Storage.
#    # Credentials should be configured.
#    # Not required if GKE with workload identity is used.
#    gcloudConfig:
#      serviceAccountKey: ...
# SAML/OIDC configuration
serviceProviderConfig:
  # Password for the key/cert file
  keyPassword: ${INSTANA_CORE_PEM_KEY_PASSWORD}
  # The combined key/cert file
  pem: |
`sed  's/^/    /' $outdir/sp.pem`
# # Required if a proxy is configured that needs authentication
# proxyConfig:
#   # Proxy user
#   user: myproxyuser
#   # Proxy password
#   password: my proxypassword
# emailConfig:
#   # Required if SMTP is used for sending e-mails and authentication is required
#   smtpConfig:
#     user: mysmtpuser
#     password: mysmtppassword
#   # Required if using for sending e-mail.
#   # Credentials should be configured.
#   # Not required if using IRSA on EKS.
#   sesConfig:
#     accessKeyId: ...
#     secretAccessKey: ...
# # Optional custom CA certificate to be added to component trust stores
# # in case internal systems Instana talks to (e.g. LDAP or alert receivers) use a custom CA.
# customCACert: |
#   -----BEGIN CERTIFICATE-----
#   <snip/>
#   -----END CERTIFICATE-----
datastoreConfigs:
  beeInstanaConfig:
    user: beeinstana-user
    password: "${BEEINSTANA_ADMIN_PASSWORD}"
  clickhouseConfigs:
    - adminUser: "${CLICKHOUSE_USER}"
      adminPassword: "${CLICKHOUSE_USER_PASSWORD}"
      user: "${CLICKHOUSE_USER}"
      password: "${CLICKHOUSE_USER_PASSWORD}"
  cassandraConfigs:
    - adminUser: instana-superuser
      adminPassword: "`${KUBECTL} get secret instana-superuser -n $CASSANDRA_NAMESPACE --template='{{index .data.password | base64decode}}'`"
      user: instana-superuser
      password: "`${KUBECTL} get secret instana-superuser -n $CASSANDRA_NAMESPACE --template='{{index .data.password | base64decode}}'`"
  postgresConfigs:
    - adminUser: postgres
      adminPassword: "`${KUBECTL} get secret postgres.postgres.credentials.postgresql.acid.zalan.do -n $POSTGRES_NAMESPACE --template='{{index .data.password | base64decode}}'`"
      user: postgres
      password: "`${KUBECTL} get secret postgres.postgres.credentials.postgresql.acid.zalan.do -n $POSTGRES_NAMESPACE --template='{{index .data.password | base64decode}}'`"
  elasticsearchConfig:
    adminUser: elastic
    adminPassword: "`${KUBECTL} get secret instana-es-elastic-user -n $ELASTIC_NAMESPACE -o go-template='{{.data.elastic | base64decode}}'`"
    user: elastic
    password: "`${KUBECTL} get secret instana-es-elastic-user -n $ELASTIC_NAMESPACE -o go-template='{{.data.elastic | base64decode}}'`"
  kafkaConfig:
    adminUser: strimzi-kafka-user
    adminPassword: "`${KUBECTL} get secret strimzi-kafka-user  -n $KAFKA_NAMESPACE --template='{{index .data.password | base64decode}}'`"
    consumerUser: strimzi-kafka-user
    consumerPassword: "`${KUBECTL} get secret strimzi-kafka-user  -n $KAFKA_NAMESPACE --template='{{index .data.password | base64decode}}'`"
    producerUser: strimzi-kafka-user
    producerPassword: "`${KUBECTL} get secret strimzi-kafka-user  -n $KAFKA_NAMESPACE --template='{{index .data.password | base64decode}}'`"
EOF
