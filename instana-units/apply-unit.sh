#!/bin/bash

outdir=`readlink -f $1`

defaultenv=`readlink -f $2`
versionenv=`readlink -f $3`
customenv=`readlink -f $4`

gitdir=`readlink -f $5`

. $defaultenv
. $versionenv
if test -f $customenv; then . $customenv; fi

version="version-$INSTANA_VERSION"

versiondir=$gitdir/$version

echo apply instana unit...

${KUBECTL} create secret generic instana-core --namespace instana-core --from-file=config.yaml=core-config.yaml

${KUBECTL} create secret generic ${INSTANA_TENANT_NAME}-${INSTANA_UNIT_NAME} --namespace instana-units \
  --from-file=config.yaml=unit-config.yaml
