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
