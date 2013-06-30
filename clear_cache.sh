#!/bin/bash -e
CURRENT=$(cd $(dirname $0) && pwd)
source $CURRENT/common.sh

rm -f $INSTALL_DIR/development/app/tmp/cache/models/*
rm -f $INSTALL_DIR/development/app/tmp/cache/persistent/*
rm -f $INSTALL_DIR/development/app/tmp/logs/*

rm -f $INSTALL_DIR/production/app/tmp/cache/models/*
rm -f $INSTALL_DIR/production/app/tmp/cache/persistent/*
rm -f $INSTALL_DIR/production/app/tmp/logs/*

