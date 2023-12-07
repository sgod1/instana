#!/bin/bash -x

version=$1
basedir=$2

./initialize-output-directory.sh $version $basedir

INSTALLDIR=$basedir/$version

. "$INSTALLDIR/default.env"
. "$INSTALLDIR/operator-versions.env"
. "$INSTALLDIR/custom.env"

./copy-scripts.sh $GITROOT $INSTALLDIR

if test ! -f $ENVROOT/bin/kubectl-instana; then
  ./download-kubectl-instana.sh "$INSTALLDIR/default.env" "$INSTALLDIR/operator-versions.env" "$INSTALLDIR/custom.env"
fi

# create instana registry pull secret yaml
