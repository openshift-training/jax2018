#!/bin/bash

oc delete statefulset pgset
oc delete sa pgset-sa
oc delete pvc pgset-pvc
oc delete pv pv1
oc delete service pgset pgset-master pgset-replica
oc delete pod pgset-0 pgset-1
