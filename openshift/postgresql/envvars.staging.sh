#!/bin/bash -x

#
# set up some env vars that all examples can relate to
#

export CCP_CLI=oc
export NAMESPACE=postgresql-staging
export PV_PATH=/exports/postgresql-staging
export NFS_IP=148.251.52.40
export NFS_HOST_NAME=osnode1.pure-delight.info
export LOCAL_IP=148.251.52.40
export DATABASE=detox_staging

export PG_MASTER_PASSWORD=aYuX0LNA67z6zRKiZx0
export PG_PRIMARY_USER=motu
export PG_USER=shopadmin
export PG_PASSWORD=DdGk8ZEdmXd51WGhjvx
export PG_ROOT_PASSWORD=6WZSApInrvKdjWDR


if [ -v $CCP_IMAGE_TAG ]; then
	export CCP_IMAGE_TAG=centos7-9.6-1.5.1
	echo "CCP_IMAGE_TAG was not found...using current tag of " $CCP_IMAGE_TAG
fi

# for PVC templates - NFS uses ReadWriteMany - EBS uses ReadWriteOnce

# for templates - allow for override of Image Path Prefix
#export CCP_IMAGE_PREFIX=172.30.240.45:5000/jeff-project
export REPLACE_CCP_IMAGE_PREFIX=crunchydata
export CCP_IMAGE_PREFIX=crunchydata
