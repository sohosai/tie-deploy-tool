#!/bin/bash -e
CURRENT=$(cd $(dirname $0) && pwd)
source $CURRENT/common.sh

# developmentディレクトリからproductionディレクトリにrsync
rsync -avr --exclude=.git $INSTALL_DIR/development/ $INSTALL_DIR/production
# DBバックアップをとる
mysqldump -u ${DB_USER} -p${DB_PASSWORD} ${DB_PRODUCTION} \
          > "${INSTALL_DIR}/backups/${TIMESTAMP}.sql"
# ログ及びキャッシュを削除
cd $INSTALL_DIR/production/
rm -rf app/tmp/logs/*
rm -rf app/tmp/cache/models/*
rm -rf app/tmp/cache/persistent/*
chmod 777 app/webroot/files/icons
# コミット
git add .
git commit -m"`date`"

