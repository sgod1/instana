#!/bin/bash

yamldir=${1:-"namespaces"}

oc apply -f `readlink -f $yamldir`
