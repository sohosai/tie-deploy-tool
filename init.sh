#!/bin/bash -e
CURRENT=$(cd $(dirname $0) && pwd)
source $CURRENT/common.sh

#  データを取得・展開
git clone git@bitbucket.org:sohosai/orange-tie.git $INSTALL_DIR/development

# submoduleの初期化
cd $INSTALL_DIR/development
git submodule init
git submodule update

# development環境からproduction環境へコピー
chmod -R 777 $INSTALL_DIR/development/app/tmp
rsync -avr --exclude=.git $INSTALL_DIR/development/ $INSTALL_DIR/production

# app/Config/constants.phpを作成
bash -E $CURRENT/update_constants.sh

# git 初期化
cd $INSTALL_DIR/production
git init

# バックアップのディレクトリ作成
mkdir -m 700 $INSTALL_DIR/backups

# DB初期状態構成
bash -E $CURRENT/manual_backup.sh
$INSTALL_DIR/development/app/Console/cake Migrations.migration run
$INSTALL_DIR/production/app/Console/cake Migrations.migration run
bash -E $CURRENT/clear_cache.sh

echo '****************************************'
echo '           CONGRATULATIONS!             '
echo '  Script have successfully initialized. '
echo '****************************************'

