#!/bin/bash

cd $(dirname $(realpath $0))


# if backup dir not defined set default
if [ -z "${BACKUP_DIR}" ]; then
    export BACKUP_DIR="$(pwd)/.data"
fi

# create backup dir if necessary
if [ ! -d ${BACKUP_DIR} ]; then
    mkdir -p ${BACKUP_DIR}
fi

# epoch time
TIMESTAMP="$(date +%s)"

if (( $(ls ${BACKUP_DIR} | wc -l) == 5 )); then
    echo "deleting ${BACKUP_DIR}/$(ls ${BACKUP_DIR} | sort | head -n 1)"
    rm -f ${BACKUP_DIR}/$(ls ${BACKUP_DIR} | sort | head -n 1)
fi

echo "creating ${BACKUP_DIR}/${TIMESTAMP}.tar.gz"
tar -czf ${BACKUP_DIR}/${TIMESTAMP}.tar.gz .data
