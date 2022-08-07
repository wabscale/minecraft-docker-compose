#!/bin/bash

cd $(dirname $(realpath $0))

BACKUP_LIMIT=${1:-12}
BACKUP_DIR=${2:-$(pwd)/.backups}
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

echo "BACKUP_LIMIT=${BACKUP_LIMIT}"
echo "BACKUP_DIR=${BACKUP_DIR}"
echo "TIMESTAMP=${TIMESTAMP}"

# create backup dir if necessary
if [ ! -d ${BACKUP_DIR} ]; then
    mkdir -p ${BACKUP_DIR}
fi

# Check the backup limit
if (( $(ls ${BACKUP_DIR} | wc -l) == ${BACKUP_LIMIT} )); then
    BACKUP_DEL="$(ls -tr ${BACKUP_DIR} | head -n 1)"
    echo "deleting ${BACKUP_DIR}/${BACKUP_DEL}"
    rm -f ${BACKUP_DIR}/${BACKUP_DEL}
fi

echo "---"
echo "creating ${BACKUP_DIR}/${TIMESTAMP}.tar.gz"
tar -I pigz -cf ${BACKUP_DIR}/${TIMESTAMP}.tar.gz .data

if [ -f backup-remote.sh ]; then
    bash -ex backup-remote.sh ${BACKUP_DIR}/${TIMESTAMP}.tar.gz
fi

