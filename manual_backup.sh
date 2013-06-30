#!/bin/bash -e
CURRENT=$(cd $(dirname $0) && pwd)
source $CURRENT/common.sh

mysqldump -u ${DB_USER} -p${DB_PASSWORD} ${DB_DEVELOPMENT} \
          > "${INSTALL_DIR}/backups/${TIMESTAMP}dev.sql"
mysqldump -u ${DB_USER} -p${DB_PASSWORD} ${DB_PRODUCTION} \
          > "${INSTALL_DIR}/backups/${TIMESTAMP}.sql"
bash -E $CURRENT/clear_cache.sh
git add .
git commit -m"manual backup `date`"

