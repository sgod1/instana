#!/bin/bash

gitroot=$1
outdir=${2:-"."}

cp $gitroot/update-environment.sh $outdir/1-update-environment.sh
cp $gitroot/apply-namespaces.sh $outdir/2-apply-namespaces.sh
cp $gitroot/install-datastore-operators.sh $outdir/3-install-datastore-operators.sh
cp $gitroot/apply-datastores.sh $outdir/4-apply-datastores.sh
cp $gitroot/install-instana-operator.sh $outdir/5-install-instana-operator.sh
cp $gitroot/instana-core/apply-core.sh $outdir/6-apply-instana-core.sh
cp $gitroot/instana-units/apply-units.sh $outdir/7-apply-instana-units.sh
