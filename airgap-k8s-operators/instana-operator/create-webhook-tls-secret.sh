#!/bin/bash

# The certificate (tls.crt) must contain the following DNS names:
#    instana-operator.<namespace>.svc
#    instana-operator.<namespace>.svc.<clusterDomain>

namespace=$1
keyfile=$1
certfile=$2

check_namespace() {
  if test -z $namespace; then
    echo namespace parameter required
    exit 1
  fi
}

check_keyfile() {
  if test -z $keyfile; then
    echo keyfile parameter required
    exit 1
  fi

  if test ! -f $keyfile; then
    echo $keyfile not found
    exit 1
  fi
}

check_certfile() {
  if test -z $certfile; then
    echo certfile parameter required
    exit 1
  fi

  if test ! -f $certfile; then
    echo $certfile not found
    exit 1
  fi
}

check_namespace
check_keyfile
check_certfile

#kubectl create secret generic instana-operator-webhook \
#    --type=kubernetes.io/tls \
#    --from-file=tls.key=path/to/tls.key \
#    --from-file=tls.crt=path/to/tls.crt \
#    --from-file=ca.crt=path/to/ca.crt

kubeclt -n $namespace create secret tls instana-operator-webhook --key=$keyfile --cert=$certfile
