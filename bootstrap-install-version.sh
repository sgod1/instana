#!/bin/bash

version=$1
basedir=$2
trace=${3:-"notrace"}

if test $trace = "trace"; then
  set -x
fi

./initialize-output-directory.sh $version $basedir

INSTALLDIR=$basedir/$version

. "$INSTALLDIR/default.env"
. "$INSTALLDIR/operator-versions.env"
. "$INSTALLDIR/custom.env"

./copy-scripts.sh $GITROOT $INSTALLDIR
