#!/bin/bash

outdir=`readlink -f $1`

defaultenv=`readlink -f $2`
versionenv=`readlink -f $3`
customenv=`readlink -f $4`

datastoredir=`readlink -f $5`

overlayname=${6:-"overlay"}

. $defaultenv
. $versionenv
. $customenv

version="version-$INSTANA_VERSION"

versiondir=$datastoredir/$version

# copy base and overlay directories to temp directory
tempdir=`mktemp -d`
cp -r $versiondir/base $tempdir
cp -r $versiondir/$overlayname $tempdir

# run overlay shell patches
for shellpatch in `ls $versiondir/$overlayname/*.sh`
do
  $shellpatch $defaultenv $versionenv $customenv $tempdir/$overlayname
done

# kustomize
oc kustomize $tempdir/$overlayname -o $outdir

# remove temp dir
rm -fr $tempdir
