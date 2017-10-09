#!/bin/sh

PJ_PATH=/home/hochuen/workspace/kuyou/yjyh/erl-sysg
SCRIPT_DIR=/home/hochuen/workspace/kuyou/yjyh/erl-sysg/script
HOUR=0
while(true)
do

if [ $HOUR = 080000 ]; then
cd $PJ_PATH
svn update
cd $SCRIPT_DIR
sh r.sh
sh tem.sh
sh make.sh
fi

HOUR=`date +%H%M%S`
done
