#!/bin/bash -x

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

# create instana registry secret
$KUBECTL apply -f $ENVROOT/instana/instana-registry.yaml -n $INSTANA_OPERATOR_NAMESPACE

# install instana operator
$ENVROOT/bin/kubectl-instana operator apply --values $ENVROOT/instana/instana-operator/values.yaml -n $INSTANA_OPERATOR_NAMESPACE
