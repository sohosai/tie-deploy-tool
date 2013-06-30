#!/bin/bash -e
CURRENT=$(cd $(dirname $0) && pwd)
source $CURRENT/common.sh

cd $INSTALL_DIR/development/
git pull
rm -rf app/tmp/cache/models/*
rm -rf app/tmp/cache/persistent/*

