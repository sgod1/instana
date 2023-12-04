#!/bin/bash

defaultenv=$1
versionenv=$2
customenv=$3

. $defaultenv
. $versionenv

if test -f $customenv; then
  . $customenv
fi

echo todo...