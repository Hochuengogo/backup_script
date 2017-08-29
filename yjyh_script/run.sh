#!/bin/sh

NODE=5101
COOKIE=bztx123

NODE_NAME=bztx_game$NODE@192.168.10.74
CONFIG_FILE=run

SMP=auto
ERL_PROCESSES=102400

cd ../config
erl +P $ERL_PROCESSES -smp $SMP -pa ../ebin -name $NODE_NAME -setcookie $COOKIE -boot start_sasl -config $CONFIG_FILE -s main server_start
