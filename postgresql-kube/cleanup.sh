#!/bin/bash

kubectl delete statefulset pgset
kubectl delete sa pgset-sa
kubectl delete pvc pgset-pvc
kubectl delete pv pv1
kubectl delete service pgset pgset-master pgset-replica
kubectl delete pod pgset-0 pgset-1
