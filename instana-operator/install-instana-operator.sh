#!/bin/bash -x

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

# create instana registry key secret
oc create secret docker-registry instana-registry \
    --namespace=$namespace \
    --docker-username=_ \
    --docker-password=$INSTANA_DOWNLOAD_KEY \
    --docker-server=artifact-public.instana.io

# install instana operator
$ENVROOT/bin/kubectl-instana operator apply --values $ENVROOT/instana/instana-operator/values.yaml -n $INSTANA_OPERATOR_NAMESPACE
