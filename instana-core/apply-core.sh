#!/bin/bash -x

outdir=`readlink -f $1`

defaultenv=`readlink -f $2`
versionenv=`readlink -f $3`
customenv=`readlink -f $4`

gitdir=`readlink -f $5`

. $defaultenv
. $versionenv
. $customenv

version="version-$INSTANA_VERSION"

versiondir=$gitdir/$version

echo apply instana core...

# depends on instana image pull secret

# create core-config.yaml from core-config.sh

# create instana-core secret from core-config.yaml

# apply core.yaml


