#!/bin/bash -x

defaultenv=`readlink -f $1`
versionenv=`readlink -f $2`
customenv=`readlink -f $3`

. $defaultenv
. $versionenv
. $customenv

oc apply -f $ENVROOT/datastores/postgres/acid.zalan.do_v1_postgresql_postgres.yaml -n $POSTGRES_NAMESPACE
