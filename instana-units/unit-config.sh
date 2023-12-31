#!/bin/bash

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`
outdir=`readlink -f $4`

. $defaultenv
. $versionenv
. $customenv

cat <<EOF > $outdir/unit-config.yaml
# The initial user of this tenant unit with admin role, default admin@instana.local.
# Must be a valid e-maiol address.
# NOTE:
# This only applies when setting up the tenant unit.
# Changes to this value won't have any effect.
initialAdminUser: ${INSTANA_ADMIN_USER}
# The initial admin password.
# NOTE:
# This is only used for the initial tenant unit setup.
# Changes to this value won't have any effect.
initialAdminPassword: ${INSTANA_ADMIN_PASSWORD}
# The Instana license. Can be a plain text string or a JSON array encoded as string. Deprecated. Use 'licenses' instead. Will no longer be supported in release 243.
# license: mylicensestring # This would also work: '["mylicensestring"]'
# A list of Instana licenses. Multiple licenses may be specified.
# licenses: [ "license1", "license2" ]
licenses: `cat $ENVROOT/instana/license.json`
# A list of agent keys. Specifying multiple agent keys enables gradually rotating agent keys.
agentKeys:
  - ${INSTANA_DOWNLOAD_KEY}
downloadKey: ${INSTANA_DOWNLOAD_KEY}
EOF
