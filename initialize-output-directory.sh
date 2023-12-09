#!/bin/bash

version=$1
basedir=$2

outdir=$basedir/$version
envroot=`readlink -f $outdir`

mkdir -p $outdir

cp default.env $outdir
cp $version-operator-versions.env $outdir/operator-versions.env

GITROOT=`pwd`
if test ! -f $outdir/custom.env; then
  cp custom-template.env $outdir/custom.env

  echo "# setting GITROOT, do not change." >> $outdir/custom.env
  echo "GITROOT=$GITROOT" >> $outdir/custom.env
  echo "#" >> $outdir/custom.env

  echo "# setting ENVROOT, do not change." >> $outdir/custom.env
  echo "ENVROOT=$envroot" >> $outdir/custom.env
  echo "#" >> $outdir/custom.env

  echo "# setting strong BEEINSTANA_ADMIN_PASSWORD." >> $outdir/custom.env
  echo "BEEINSTANA_ADMIN_PASSWORD=$(base64 < /dev/urandom | head -c32)" >> $outdir/custom.env
  echo "#" >> $outdir/custom.env
fi

mkdir -p $outdir/bin

mkdir -p $outdir/instana/instana-operator
mkdir -p $outdir/instana/instana-core
mkdir -p $outdir/instana/instana-units

mkdir -p $outdir/datastores/zookeeper
mkdir -p $outdir/datastores/kafka
mkdir -p $outdir/datastores/elastic
mkdir -p $outdir/datastores/postgres
mkdir -p $outdir/datastores/cassandra
mkdir -p $outdir/datastores/clickhouse
mkdir -p $outdir/datastores/beeinstana
