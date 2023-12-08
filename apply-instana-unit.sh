#!/bin/bash -x

defaultenv=`readlink -f ./default.env`
versionenv=`readlink -f ./operator-versions.env`
customenv=`readlink -f ./custom.env`

. $defaultenv
. $versionenv
. $customenv

$GITROOT/instana-units/apply-unit.sh $defaultenv $versionenv $customenv
