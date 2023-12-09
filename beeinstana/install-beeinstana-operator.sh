#!/bin/bash

defaultenv=$1
versionenv=$2
customenv=$3

. $defaultenv
. $versionenv
. $customenv

# instana registry secret
$KUBECTL apply -f $ENVROOT/instana/instana-registry.yaml -n $BEEINSTANA_NAMESPACE

# beeinstana helm repo
helm repo add instana $BEEINSTANA_HELM_REPO --username _ --password $INSTANA_DOWNLOAD_KEY
helm repo update

# install latest beeinstana helm chart version
helm install $BEEINSTANA_HELM_RELEASE instana/beeinstana-operator --namespace=$BEEINSTANA_NAMESPACE --set operator.securityContext.seccompProfile.type=RuntimeDefault
