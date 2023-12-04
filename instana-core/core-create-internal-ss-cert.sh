#!/bin/bash -x

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

outdir=$ENVROOT/instana/instana-core

openssl genrsa -aes128 -out $outdir/key.pem -passout pass:${KEY_PEM_PASSWORD} 2048

cat > $outdir/internal_csr_details.txt <<-EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn
[dn]
C=US
ST=CA
L=Los Angeles
O=Hello
OU=World
emailAddress=my@szesto.io
CN=${INSTANA_BASE_DOMAIN}
EOF

openssl req -new -x509 -key key.pem -days 365 \
         -passin pass:${INSTANA_CORE_KEY_PEM_PASSWORD} -out $outdir/cert.pem \
         -config $outdir/internal_csr_details.txt

cat $outdir/key.pem $outdir/cert.pem > $outdir/sp.pem
