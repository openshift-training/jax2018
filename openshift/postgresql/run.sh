#!/bin/bash

source ./envvars.sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/cleanup.sh

# create the service account used in the containers
envsubst < $DIR/set-sa.json | oc create -f -

# as of Kube 1.6, we need to allow the service account to perform
# a label command, for this example, we open up wide permissions
# for all serviceaccounts, this is NOT for production!
kubectl create clusterrolebinding permissive-binding \
  --clusterrole=cluster-admin \
  --user=admin \
  --user=kubelet \
  --group=system:serviceaccounts

# create the services for the example
oc create -f $DIR/set-service.json
oc create -f $DIR/set-master-service.json
oc create -f $DIR/set-replica-service.json

# create some sample pv to use
envsubst < $DIR/pv1.json | oc create -f -
# envsubst < $DIR/pv2.json | oc create -f -
# envsubst < $DIR/pv3.json | oc create -f -

# create the pvc we will use for all pods in the set

envsubst < $DIR/pvc.json | oc create -f -

# create the stateful set
envsubst < $DIR/set.json | oc create -f -
