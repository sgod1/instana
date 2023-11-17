#!/bin/bash

envdir=$1
release=$2
subrelease=$3
version=$4

if test -z $envdir; then
  echo envdir argument required
  exit 1
fi

if test -z $release; then
  echo release argument required
  exit 1
fi

outdir="$envdir/$version"

mkdir -p "$outdir"

cat <<EOF > "$outdir/instana-images.list"
# list of version specific instana images
#
# install os and version specific kubectl instana plugin.
# documentation page, look for 'Manual installation':
# https://www.ibm.com/docs/en/instana-observability/259?topic=installing-instana-kubectl-plug-in
#
# run kubectl instana images >> instana-images.list
EOF

cat <<EOF > "$outdir/operator-images.list"
# copy and paste version-specfic list of operator images, eg:
# https://www.ibm.com/docs/en/instana-observability/259?topic=stores-using-kubernetes-operators
# search for "The following images are needed for the pinned Helm chart versions of this document"
EOF

if test -f ./versions/$version-operator-images.list; then
  cat ./versions/$version-operator-images.list >> "$outdir/operator-images.list"
fi

if test -f $outdir/kubectl-instana; then
  env -i -v PATH="${outdir}:${PATH}" kubectl instana images >> "$outdir/instana-images.list"
fi
