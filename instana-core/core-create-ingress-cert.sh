#!/bin/bash -x

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

outdir=$ENVROOT/instana/instana-core
mkdir -p $outdir

# generate ca private key
openssl genrsa -out $outdir/ca.key 2048

# generate ca cert
openssl req -new -x509 -days 365 -key $outdir/ca.key -subj "/C=US/ST=CA/L=Los Angeles/O=Hello World/CN=Root CA" -out $outdir/ca.crt

# base domain
core_tls_csr="tls.csr"
core_tls_cert="tls.crt"

# generate instana-base-domain certificate request
openssl req -newkey rsa:2048 -nodes -keyout $outdir/tls.key -subj "/C=US/ST=CA/L=Los Angeles/O=Hello World/CN=*.${INSTANA_BASE_DOMAIN}" -out $outdir/$core_tls_csr.csr

# sign instana-base-domain csr with ca key
openssl x509 -req -extfile <(printf "subjectAltName=DNS:${INSTANA_BASE_DOMAIN},DNS:${INSTANA_TENANT_DOMAIN},DNS:${INSTANA_AGENT_ACCEPTOR}") \
  -days 365 -in $outdir/$core_tls_csr -CA ca.crt -CAkey $outdir/ca.key -CAcreateserial -out $outdir/$core_tls_cert
