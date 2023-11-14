#!/bin/bash

envdir=$1
version=$2
outputdir=$3
values=${4:-"values.yaml"}

if test -z $envdir; then
  echo envdir parameter required
  exit 1
fi

if test -z $version; then
  echo version parameter required
  exit 1
fi

if test -z $outputdir; then
  echo outputdir parameter required
  exit 1
fi

env -i PATH=$envdir/$verson:$PATH kubectl instana operator template --output-dir $outputdir --values $values
