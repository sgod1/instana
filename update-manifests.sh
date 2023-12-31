#!/bin/bash

overlay=${1:-"overlay"}

defaultenv=`readlink -f default.env`
versionenv=`readlink -f operator-versions.env`
customenv=`readlink -f custom.env`

. $defaultenv
. $versionenv
. $customenv

outdir=`readlink -f .`

$GITROOT/namespace-builder.sh $defaultenv $versionenv $customenv $outdir/namespaces

datastore="kafka"
$GITROOT/kustomize-builder.sh $outdir/datastores/$datastore $defaultenv $versionenv $customenv $GITROOT/$datastore $overlay

datastore="elastic"
$GITROOT/kustomize-builder.sh $outdir/datastores/$datastore $defaultenv $versionenv $customenv $GITROOT/$datastore $overlay

datastore="postgres"
$GITROOT/kustomize-builder.sh $outdir/datastores/$datastore $defaultenv $versionenv $customenv $GITROOT/$datastore $overlay

datastore="cassandra"
$GITROOT/kustomize-builder.sh $outdir/datastores/$datastore $defaultenv $versionenv $customenv $GITROOT/$datastore $overlay

datastore="clickhouse"
$GITROOT/kustomize-builder.sh $outdir/datastores/$datastore $defaultenv $versionenv $customenv $GITROOT/$datastore $overlay

datastore="beeinstana"
$GITROOT/kustomize-builder.sh $outdir/datastores/$datastore $defaultenv $versionenv $customenv $GITROOT/$datastore $overlay

# instana-operator
$GITROOT/instana-operator/kustomize-builder.sh $outdir/instana/instana-operator $defaultenv $versionenv $customenv $GITROOT/instana-operator $overlay

# instana-core
component="instana-core"
$GITROOT/kustomize-builder.sh $outdir/instana/$component $defaultenv $versionenv $customenv $GITROOT/$component $overlay

# instana-unit
component="instana-units"
$GITROOT/kustomize-builder.sh $outdir/instana/$component $defaultenv $versionenv $customenv $GITROOT/$component $overlay
