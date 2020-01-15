#!/bin/bash

cd $(dirname $(realpath $0))

BACKUP_DIR=/srv/samba/share/minecraft-backups

mkdir -p ${BACKUP_DIR}
sudo chown jc:jc ${BACKUP_DIR}

TIMESTAMP="$(date +%s)"

if (( $(ls ${BACKUP_DIR} | wc -l) == 5 )); then
    echo "deleting ${BACKUP_DIR}/$(ls ${BACKUP_DIR} | sort | head -n 1)"
    rm -f ${BACKUP_DIR}/$(ls ${BACKUP_DIR} | sort | head -n 1)
fi

echo "creating ${BACKUP_DIR}/${TIMESTAMP}.tar.gz"
tar -czf ${BACKUP_DIR}/${TIMESTAMP}.tar.gz .data
