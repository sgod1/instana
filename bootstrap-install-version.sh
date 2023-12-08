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
if test ! -f $ENVROOT/instana/instana-registry.yaml; then
  $KUBECTL create secret docker-registry instana-registry --docker-username=_ --docker-password=$INSTANA_DOWNLOAD_KEY \
    --docker-server=artifact-public.instana.io -o yaml --dry-run=client > $ENVROOT/instana/instana-registry.yaml
fi

# download instana license
if test ! -f $ENVROOT/instana/license.json; then
  $ENVROOT/bin/kubectl-instana license download --sales-key $INSTANA_SALES_KEY --filename $ENVROOT/instana/license.json
fi
