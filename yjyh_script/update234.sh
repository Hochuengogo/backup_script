#!/bin/sh

EBIN_DIR=/home/hochuen/workspace/kuyou/yjyh/erl-sysg/ebin
TEMP_DIR=/home/hochuen/workspace/kuyou/yjyh/erl-sysg/temp
INCLUDE=/home/hochuen/workspace/kuyou/yjyh/erl-sysg/include
TOOLS=/home/hochuen/workspace/kuyou/yjyh/erl-sysg/tools

scp -r -P22 $EBIN_DIR root@192.168.10.234:/sysg_server
scp -r -P22 $TEMP_DIR root@192.168.10.234:/sysg_server
scp -r -P22 $INCLUDE root@192.168.10.234:/sysg_server
scp -r -P22 $TOOLS root@192.168.10.234:/sysg_server

ssh root@192.168.10.234 "sh /sysg_server/start.sh "
