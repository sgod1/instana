#!/bin/bash

defaultenv=`readlink -f ./default.env`
versionenv=`readlink -f ./operator-versions.env`
customenv=`readlink -f ./custom.env`

. $defaultenv
. $versionenv
. $customenv

$GITROOT/instana-operator/install-instana-operator.sh $defaultenv $versionenv $customenv
