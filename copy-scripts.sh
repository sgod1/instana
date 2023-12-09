#!/bin/bash

gitroot=$1
outdir=${2:-"."}

cp $gitroot/install-instana-prereq.sh $outdir/0-install-instana-prereq.sh
cp $gitroot/update-environment.sh $outdir/1-update-environment.sh
cp $gitroot/apply-namespaces.sh $outdir/2-apply-namespaces.sh
cp $gitroot/install-datastore-operators.sh $outdir/3-install-datastore-operators.sh
cp $gitroot/apply-datastores.sh $outdir/4-apply-datastores.sh
cp $gitroot/install-instana-operator.sh $outdir/5-install-instana-operator.sh
cp $gitroot/create-base-domain-tls-secret.sh $outdir/create-base-domain-tls-secret.sh
cp $gitroot/apply-instana-core.sh $outdir/6-apply-instana-core.sh
cp $gitroot/apply-instana-unit.sh $outdir/7-apply-instana-unit.sh
cp $gitroot/create-instana-routes.sh $outdir/8-create-isntana-routes.sh
