#!/bin/bash

namespace=$1

if test -z $namespace; then
  echo namespace parameter required
  exit 1
fi

kubectl create namespace $namespace

