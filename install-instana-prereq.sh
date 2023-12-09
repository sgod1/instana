#!/bin/bash

defaultenv=`readlink -f ${1:-"./default.env"}`
versionenv=`readlink -f ${2:-"./operator-versions.env"}`
customenv=`readlink -f ${3:-"./custom.env"}`

. $defaultenv
. $versionenv
. $customenv

# install kubectl plugin
if test ! -f $ENVROOT/bin/kubectl-instana; then
  $GITROOT/download-kubectl-instana.sh $defaultenv $versionenv $customenv
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
