#!/bin/bash -x

#
# set up some env vars that all examples can relate to
#

export CCP_CLI=oc
export NAMESPACE=default
export PV_PATH=/exports/postgresql
export NFS_IP=192.168.64.5
export NFS_HOST_NAME=192.168.64.5
export LOCAL_IP=192.168.64.5
export DATABASE=workshopdb

export PG_MASTER_PASSWORD=akjsdhfjklahsdkjfhjkas
export PG_PRIMARY_USER=motu
export PG_USER=admin
export PG_PASSWORD=jjkdhfjhsdjkfhsdf
export PG_ROOT_PASSWORD=fsdfljsdflj


if [ -v $CCP_IMAGE_TAG ]; then
	export CCP_IMAGE_TAG=centos7-9.6-1.5.1
	echo "CCP_IMAGE_TAG was not found...using current tag of " $CCP_IMAGE_TAG
fi

# for PVC templates - NFS uses ReadWriteMany - EBS uses ReadWriteOnce

# for templates - allow for override of Image Path Prefix
#export CCP_IMAGE_PREFIX=172.30.240.45:5000/jeff-project
export REPLACE_CCP_IMAGE_PREFIX=crunchydata
export CCP_IMAGE_PREFIX=crunchydata
